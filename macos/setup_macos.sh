#!/usr/bin/env bash
## Automated system setup and initialization script for macOS.
set -uo pipefail

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
    brew list "$1" &>/dev/null \
        && echo "  [skip] $1 already installed" \
        || run_step "$1" brew install "$1"
}

brew_cask_install() {
    local name="${1##*/}"  # strip tap prefix (e.g. nikitabobko/tap/aerospace -> aerospace)
    if brew list --cask "$name" &>/dev/null; then
        echo "  [skip] $name already installed"
        return
    fi
    echo "  [install] $1"
    brew install --cask --overwrite "$1" || fail "$name"
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
brew_install lsd
brew_install ripgrep
brew_install bat
brew_install fd

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
link_config "${DOTFILES}/aerospace"          "${HOME}/.config/aerospace"
link_config "${DOTFILES}/ghostty"            "${HOME}/.config/ghostty"
link_config "${DOTFILES}/nvim"               "${HOME}/.config/nvim"
link_config "${DOTFILES}/tmux"               "${HOME}/.config/tmux"
link_config "${DOTFILES}/finicky/finicky.js" "${HOME}/.finicky.js"

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
