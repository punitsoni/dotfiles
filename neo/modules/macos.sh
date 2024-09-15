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

install_essential() {
  packages=(
    git
    tmux
    fzf
    neovim
    npm
  )
  brew install "${packages[@]}"
}

install_optional() {
  packages=(
    # Pretty version of cat.
    bat
    # lolcat
    # jshon
    # recode
    # wget
  )
  brew install "${packages[@]}"
}

cmd::macos_setup() {
  set -o errexit
  check_brew_install
  brew update

  echo "Installing packages..."
  install_essential
  install_optional

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
