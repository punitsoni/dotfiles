#!/usr/bin/env bash

set -o pipefail

cmd::webs() {
  uv run --project "${DOTFILES}/webs" webs "$@"
}
