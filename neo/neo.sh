#!/usr/bin/env bash
set -o pipefail

# Get directory containing the this script.
export NEODIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${NEODIR}"/require.sh

require fzf_rg
require misc
require macos

get_subcommands() {
  # List all declared functions that match pattern "cmd::*"
  declare -F | sed -n '/cmd::/s/.*cmd:://p'
}

show_usage() {
  echo "Usage:"
  echo ""
  echo "  neo <command> [options]"
  echo ""
  echo "Available commands:"

  # Read output of get_commands line by line.
  while IFS= read -r line; do
    echo "  ${line}"
  done < <(get_subcommands)
}

cmd::help() {
  show_usage
}

main() {
  # Ensure at least one argument is passed.
  if [[ $# -lt 1 ]]; then
    show_usage
    exit 1
  fi
  subcommand="$1"

  # TODO: handle global opts here before executing subcommand.

  # Get the function associated with the subcommand.
  func="cmd::${subcommand}"

  if ! declare -F "${func}" >/dev/null; then
    echo "No command ${subcommand}"
    exit 1
  fi

  # Remove first argument and then call the subcommand with the rest of the
  # arguments.
  shift && ${func} "$@"
}

main "$@"
