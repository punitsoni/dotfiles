#!/usr/bin/env bash

set -o pipefail

check_brew_install() {
  # Check if homebrew is installed.
  if [[ "$(which brew)" ]]; then
    return
  fi
  echo "Homebrew not found. Installing now..."
  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
}

macos_configure() {
  # Set fast key repeat rate
  # defaults write NSGlobalDomain KeyRepeat -int 0
  # Require password as soon as screensaver or sleep mode starts
  # defaults write com.apple.screensaver askForPassword -int 1
  # defaults write com.apple.screensaver askForPasswordDelay -int 0
  # Show filename extensions by default
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true
  # Enable tap-to-click
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
  defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
}

install_packages() {
  packages=(
    git
    tmux
    fzf
    neovim
    npm
    lazygit
    python
    font-fira-code-nerd-font
    bat
    koekeishiya/formulae/yabai
    koekeishiya/formulae/skhd
  )
  brew install "${packages[@]}"
}

link_configs() {
  echo "Link config: nvim"
  ln -s ${DOTFILES}/nvim ${HOME}/.config/nvim

  echo "Link config: tmux"
  ln -s ${DOTFILES}/tmux ${HOME}/.config/tmux

  echo "Link config: yabai"
  mkdir -p ~/.config/yabai
  rm -f ~/.config/yabai/yabairc
  ln -s ${DOTFILES}/macos/yabairc ~/.config/yabai/yabairc
  mkdir -p ~/.config/skhd
  rm -f ~/.config/skhd/skhdrc
  ln -s ${DOTFILES}/macos/skhdrc ~/.config/skhd/skhdrc
}

cmd::macos_setup() {
  set -o errexit
  check_brew_install
  brew update

  echo "Installing packages..."
  install_packages

  link_config

  echo "Configuring MacOS..."
  macos_configure
}

cmd::restart_yabai() {
  echo 'Stopping yabai and skhd'
  yabai --stop-service
  skhd --stop-service
  echo 'Starting yabai and skhd'
  yabai --start-service
  skhd --start-service
  echo 'DONE'
}

cmd::stop_yabai() {
  echo 'Stopping yabai and skhd'
  yabai --stop-service
  skhd --stop-service
  echo 'DONE'
}

# Reference
# https://medium.com/macoclock/automating-your-macos-setup-with-homebrew-and-cask-e2a103b51af1
