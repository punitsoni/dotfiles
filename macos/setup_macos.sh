## Automated system setup and initialization script


if [[ -z "$DOTFILES" || ! -d "$DOTFILES" ]]; then
    echo "Error: \$DOTFILES is not set or does not exist. Clone dotfiles and set \$DOTFILES first."
    exit 1
fi

# TODO Install Homebrew

if ! command -v brew &>/dev/null; then
    echo "Error: Homebrew is not installed. Install it from https://brew.sh first."
    exit 1
fi

brew_install() {
    brew list "$1" &>/dev/null || { echo "Installing $1..."; brew install "$1"; }
}

brew_cask_install() {
    brew list --cask "$1" &>/dev/null || { echo "Installing $1..."; brew install --cask "$1"; }
}

link_config() {
    local src="$1" dst="$2"
    if [[ -e "$dst" || -L "$dst" ]]; then
        echo "Already linked: $dst"
    else
        echo "Linking $dst"
        ln -s "$src" "$dst"
    fi
}

# Install apps
brew tap nikitabobko/tap
brew_cask_install nikitabobko/tap/aerospace
brew_cask_install ghostty
brew_cask_install visual-studio-code
brew_cask_install font-fira-code-nerd-font
brew_install fzf

# Install Configs
link_config ${DOTFILES}/aerospace ${HOME}/.config/aerospace
link_config ${DOTFILES}/ghostty ${HOME}/.config/ghostty
link_config ${DOTFILES}/finicky/finicky.js ${HOME}/.finicky.js
