#!/bin/sh
#
# Runs a lua script inside neovim environment
#

if (( $# != 1 )); then
  echo "Usage: $0 <file.lua>"
fi

nvim --headless --cmd ":source $1" --cmd ":q"

