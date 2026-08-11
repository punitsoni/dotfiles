#!/usr/bin/env bash

set -o pipefail

# Rebuild and activate the nix-darwin system configuration.
#
# Stages nix/ first because flakes only evaluate git-tracked files — a newly
# added .nix module is invisible to the flake until `git add`ed. Activation
# needs root; we invoke it via `nix run nix-darwin` (self-contained) rather
# than `darwin-rebuild`, since the latter isn't on root's PATH under sudo.
#
# Usage: neo nix-apply [config]   (config defaults to "work")
cmd::nix-apply() {
  local config="${1:-work}"
  git -C "${DOTFILES}" add nix/ || return 1
  sudo nix run nix-darwin -- switch --flake "${DOTFILES}/nix#${config}"
}

# Build the config without activating it (no sudo, no system changes).
# Useful for validating changes before a real switch.
#
# Usage: neo nix-build [config]
cmd::nix-build() {
  local config="${1:-work}"
  git -C "${DOTFILES}" add nix/ || return 1
  nix build --out-link /tmp/nix-result "${DOTFILES}/nix#darwinConfigurations.${config}.system"
}
