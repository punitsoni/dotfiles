#!/usr/bin/env bash
set -o pipefail

# Get directory containing the this script.
NEODIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

flag_load_defaults=true
flag_verbose=false

# echo to stderr
perr() {
  echo "$1" >&2
}

logv() {
  if [[ "${flag_verbose}" == "true" ]]; then
    perr "$1"
  fi
}

die() {
  if [[ -n $1 ]]; then
    perr "Error: $1"
  fi
  exit 1
}

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

  # Read output of get_commands line by line.
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

  if [[ "${flag_load_defaults}" == "true" ]]; then
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
      flag_load_defaults=false
      ;;
    -v | --verbose)
      flag_verbose=true
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
