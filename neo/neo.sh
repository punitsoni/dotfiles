#!/usr/bin/env bash
set -o pipefail

# Get directory containing the this script.
export NEODIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

flag_load_defaults=true
flag_verbose=false

list_commands() {
  # List all declared functions that match pattern "cmd::*"
  declare -F | sed -n '/cmd::/s/.*cmd:://p'
}

show_usage() {
  echo "Usage:"
  echo ""
  echo "  neo [global_options] <command> [options]"
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
    # show_usage
    # exit 1
    die "command required"
  fi

  command="$1"

  # Get the function associated with the command.
  func="cmd::${command}"

  if ! declare -F "${func}" >/dev/null; then
    echo "Unknown command: ${command}"
    exit 1
  fi

  # Remove first argument and then call the command with the rest of the
  # arguments.
  shift && ${func} "$@"
}

logv() {
  if [[ "${flag_verbose}" == "true" ]]; then
    echo "$1"
  fi
}


die() {
  if [[ -n $1 ]]; then
    echo "Error: $1"
  fi
  exit 1
}

load_modules() {
  default_mods=(
    "${NEODIR}"/modules/fzf_rg.sh
    "${NEODIR}"/modules/misc.sh
    "${NEODIR}"/modules/macos.sh
  )
  extra_mods="$@"

  if [[ "${flag_load_defaults}" == "true" ]]; then
    for mod in "${default_mods[@]}"; do
      logv "loading module: ${mod}"
      source "${mod}" || die "cannot load module ${mod}"
    done
  fi

  for mod in ${extra_mods}; do
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

  # Load modules that provide commands.
  load_modules "${extra_modules[@]}"

  execute_command "$@"
}

main "$@"
