#!/usr/bin/env bash
## Automated system setup and initialization script for macOS.
set -uo pipefail

export HOMEBREW_NO_AUTO_UPDATE=1
export NONINTERACTIVE=1

# Tee all output to log file.
exec > >(tee /tmp/setup_macos.log) 2>&1

SERVER_MODE=0
for arg in "$@"; do
    case "$arg" in
        --server-mode) SERVER_MODE=1 ;;
        *) echo "Unknown argument: $arg"; exit 1 ;;
    esac
done

if [[ -z "${DOTFILES:-}" || ! -d "$DOTFILES" ]]; then
    echo "Error: \$DOTFILES is not set or does not exist. Clone dotfiles and set \$DOTFILES first."
    exit 1
fi

# --------------------------------------------------------------------------- #
# Helpers
# --------------------------------------------------------------------------- #

FAILURES=()

step() { echo; echo "==> $*"; }

fail() { echo "  [error] $*" >&2; FAILURES+=("$*"); }

run_step() {
    local label="$1"; shift
    "$@" || fail "$label"
}

brew_install() {
    if brew list "$1" &>/dev/null; then
        echo "  [skip] $1 already installed"
    else
        run_step "$1" brew install "$1"
    fi
}

brew_cask_install() {
    local name="${1##*/}"  # strip tap prefix (e.g. nikitabobko/tap/aerospace -> aerospace)
    if brew list --cask "$name" &>/dev/null || [[ -d "/opt/homebrew/Caskroom/$name" ]]; then
        echo "  [skip] $name already installed"
        return
    fi
    echo "  [install] $1"
    brew install --cask --force "$1" || fail "$name"
}

link_config() {
    local src="$1" dst="$2"
    mkdir -p "$(dirname "$dst")"
    if [[ -e "$dst" || -L "$dst" ]]; then
        echo "  [skip] $dst already linked"
    else
        echo "  [link] $dst -> $src"
        ln -s "$src" "$dst" || fail "link $dst"
    fi
}

# --------------------------------------------------------------------------- #
# Homebrew
# --------------------------------------------------------------------------- #

step "Homebrew"
if ! command -v brew &>/dev/null; then
    echo "  [install] Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || fail "Homebrew"
else
    echo "  [skip] Homebrew already installed"
fi

# --------------------------------------------------------------------------- #
# GUI Apps
# --------------------------------------------------------------------------- #

step "GUI Apps"
brew tap nikitabobko/tap --quiet
brew_cask_install nikitabobko/tap/aerospace
brew_cask_install ghostty
brew_cask_install visual-studio-code
brew_cask_install finicky
brew_cask_install mos

# --------------------------------------------------------------------------- #
# Fonts
# --------------------------------------------------------------------------- #

step "Fonts"
brew_cask_install font-fira-code-nerd-font

# --------------------------------------------------------------------------- #
# CLI Tools
# --------------------------------------------------------------------------- #

step "CLI Tools"
brew_install fzf
brew_install neovim
brew_install tmux
brew_install zellij
brew_install lsd
brew_install ripgrep
brew_install bat
brew_install fd
brew_install shellcheck
brew_install uv

# --------------------------------------------------------------------------- #
# Tmux Plugin Manager (TPM)
# --------------------------------------------------------------------------- #

step "Tmux Plugin Manager"
TPM_DIR="${HOME}/.config/tmux/plugins/tpm"
if [[ ! -d "$TPM_DIR" ]]; then
    echo "  [install] TPM"
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR" || fail "TPM"
else
    echo "  [skip] TPM already installed"
fi

# --------------------------------------------------------------------------- #
# Link Configs
# --------------------------------------------------------------------------- #

step "Linking configs"
run_step "AeroSpace config" bash "${DOTFILES}/aerospace/setup.sh"
link_config "${DOTFILES}/ghostty"            "${HOME}/.config/ghostty"
link_config "${DOTFILES}/nvim"               "${HOME}/.config/nvim"
link_config "${DOTFILES}/tmux"               "${HOME}/.config/tmux"
link_config "${DOTFILES}/zellij/config.kdl"  "${HOME}/.config/zellij/config.kdl"
link_config "${DOTFILES}/finicky/finicky.js" "${HOME}/.finicky.js"

# --------------------------------------------------------------------------- #
# Neovim plugins (Lazy.nvim headless sync)
# --------------------------------------------------------------------------- #

step "Neovim plugins"
if command -v nvim &>/dev/null; then
    echo "  [sync] Installing/updating plugins via Lazy.nvim..."
    nvim --headless "+Lazy! sync" +qa 2>&1 | sed 's/^/  /' >/dev/null || fail "Neovim plugin sync"
    echo "  [done] Plugin sync complete"
else
    echo "  [skip] nvim not found"
fi

# --------------------------------------------------------------------------- #
# Caps Lock -> Control remapping (via hidutil LaunchAgent)
# --------------------------------------------------------------------------- #

step "Caps Lock -> Control"
KEYREMAP_SRC="${DOTFILES}/macos/com.local.KeyRemapping.plist"
KEYREMAP_DST="${HOME}/Library/LaunchAgents/com.local.KeyRemapping.plist"
mkdir -p "${HOME}/Library/LaunchAgents"
if ! cmp -s "$KEYREMAP_SRC" "$KEYREMAP_DST"; then
    echo "  [install] com.local.KeyRemapping.plist"
    cp "$KEYREMAP_SRC" "$KEYREMAP_DST" || fail "KeyRemapping plist"
    launchctl unload "$KEYREMAP_DST" 2>/dev/null || true
    launchctl load "$KEYREMAP_DST" || fail "KeyRemapping launchctl"
else
    echo "  [skip] Key remapping already installed"
fi

# --------------------------------------------------------------------------- #
# macOS KeyBindings (Home/End key fix + text editing shortcuts)
# --------------------------------------------------------------------------- #

step "KeyBindings"
mkdir -p "${HOME}/Library/KeyBindings"
KEYBINDINGS_SRC="${DOTFILES}/macos/DefaultKeyBinding.dict"
KEYBINDINGS_DST="${HOME}/Library/KeyBindings/DefaultKeyBinding.dict"
if ! cmp -s "$KEYBINDINGS_SRC" "$KEYBINDINGS_DST"; then
    echo "  [install] DefaultKeyBinding.dict"
    cp "$KEYBINDINGS_SRC" "$KEYBINDINGS_DST" || fail "KeyBindings"
else
    echo "  [skip] KeyBindings already up to date"
fi

# --------------------------------------------------------------------------- #
# Server Mode (lid closed, ethernet, power)
# --------------------------------------------------------------------------- #

if [[ "$SERVER_MODE" -eq 1 ]]; then
    step "Server Mode"
    run_step "server_mode.sh" bash "${DOTFILES}/macos/server_mode.sh"
fi

# --------------------------------------------------------------------------- #
# Summary
# --------------------------------------------------------------------------- #

echo ""
if [[ ${#FAILURES[@]} -gt 0 ]]; then
    echo "Done with ${#FAILURES[@]} failure(s):"
    for f in "${FAILURES[@]}"; do
        echo "  - $f"
    done
    exit 1
else
    echo "Done."
fi
