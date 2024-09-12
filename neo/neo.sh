#!/usr/bin/env bash
set -o pipefail

show_usage_and_exit() {
  echo "Usage: neo <command> [options]"
  echo "Commands:"
  echo "  help     Display this help message"
  exit 1
}

cmd__help() {
  show_usage_and_exit
}

cmd__test() {
  get_scriptdir
}

get_scriptdir() {
  echo $(cd $(dirname "$BASH_SOURCE") && pwd)
}

execute_subcommand() {
  # Map command to function.
  cmd_func="cmd__$1"

  # TODO: exit if function does not exist.

  # Remove first argument and then call the command func with
  # rest of the arguments.
  shift && ${cmd_func} $@
}

main() {
  # Ensure at least one argument is passed
  if [ $# -lt 1 ]; then
    show_usage_and_exit
  fi

  export NEODIR=$(get_scriptdir)

  # TODO: handle global opts here before executing subcommand.
  execute_subcommand $@
}

main $@
