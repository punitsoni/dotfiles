#!/usr/bin/env bash
set -o pipefail

# Get directory containing the this script.
NEODIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${NEODIR}"/lib/util.sh

FLAG_load_defaults=true
FLAG_verbose=false

list_commands() {
  # List all declared functions that match pattern "cmd::*"
  declare -F | sed -n '/cmd::/s/.*cmd:://p'
}

show_usage() {
  echo "Usage:"
  echo ""
  echo "  neo [options] <command> [command_args]"
  echo ""
  echo "Global options:"
  echo "  --no-default: Disable loading default modules"
  echo ""
  echo "Available commands:"

  # Read output of `list_commands` line by line.
  while IFS= read -r line; do
    echo "  ${line}"
  done < <(list_commands)
}

cmd::help() {
  show_usage
}

execute_command() {
  # Ensure that at least one positional argument is present.
  if [[ "$1" == "" ]]; then
    perr "Error: command required"
    echo ""
    show_usage && exit 1
  fi

  command="$1"

  # Get the function associated with the command.
  func="cmd::${command}"

  if ! declare -F "${func}" >/dev/null; then
    die "Unknown command: ${command}"
  fi

  # Remove first argument and then call the command with the rest of the
  # arguments.
  shift && ${func} "$@"
}

load_modules() {

  if [[ "${FLAG_load_defaults}" == "true" ]]; then
    # Load default modules.
    for mod in "${NEODIR}"/modules/*.sh; do
      logv "loading module: ${mod}"
      source "${mod}" || die "cannot load module ${mod}"
    done
  fi

  for mod in $@; do
    logv "loading module: ${mod}"
    source "${mod}" || die "cannot load module ${mod}"
  done
}

main() {

  # Handle global options.
  extra_modules=()

  while [[ "$1" =~ ^- ]]; do
    case "$1" in
    -h | --help)
      load_modules "${extra_modules}"
      execute_command help
      exit
      ;;
    --no-default)
      FLAG_load_defaults=false
      ;;
    -v | --verbose)
      FLAG_verbose=true
      ;;
    -m | --module)
      if [[ "$2" =~ ^- ]]; then
        die "module name required after $1"
      fi
      extra_modules+=("$2")
      shift
      ;;
    *)
      die "unknown option: $1"
      ;;
    esac
    shift
  done

  # Load commands from the modules.
  load_modules "${extra_modules[@]}"

  # Execute requested command.
  execute_command "$@"
}

main "$@"
