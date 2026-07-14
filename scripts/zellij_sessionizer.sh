#!/usr/bin/env bash
# Prints a selected zellij session name to stdout (for use by the zm() shell function).
# Does NOT call zellij attach — the caller handles that.

selector() {
  fzf --height=~100% --prompt='> '
}

available_sessions() {
  zellij list-sessions -n 2>/dev/null | grep -v 'EXITED' | awk '{print $1}'
  echo "** New Session **"
}

zellij_running() {
  [[ -n $(zellij list-sessions -n 2>/dev/null | grep -v 'EXITED') ]]
}

# ---- Main ---- #

# If a session name was given, just print it back.
if [[ $# -eq 1 ]]; then
  echo "$1"
  exit 0
fi

# Interactive picker.
if ! zellij_running; then
  read -rp 'New session: ' session
  echo "$session"
  exit 0
fi

session=$(available_sessions | selector)
[[ -z "$session" ]] && exit 0

if [[ "$session" == '** New Session **' ]]; then
  read -rp 'New session: ' session
fi

echo "$session"
