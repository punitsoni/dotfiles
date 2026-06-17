#!/usr/bin/env bash
# Prints a selected tmux session name to stdout (for use by the tm() shell function).
# Does NOT call tmux attach/switch — the caller handles that.

selector() {
  fzf --height=~100% --prompt='> '
}

available_sessions() {
  tmux list-sessions 2>/dev/null | awk -F':' '{print $1}'
  echo "** New Session **"
}

tmux_running() {
  tmux list-sessions &>/dev/null
}

# ---- Main ---- #

# If a session name was given, just print it back.
if [[ $# -eq 1 ]]; then
  echo "$1"
  exit 0
fi

# Interactive picker.
if ! tmux_running; then
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
