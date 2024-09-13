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
  echo "Installing packages..."
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
  echo "Installing packages..."
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

  install_essential
  install_optional

  echo "Configuring MacOS..."
  macos_configure
}

# Reference
# https://medium.com/macoclock/automating-your-macos-setup-with-homebrew-and-cask-e2a103b51af1
