#!/usr/bin/env bash

selector() {
  fzf --height=~100% --prompt='> '
}

available_sessions() {
  tmux list-sessions | awk -F':' '{print $1}'
  echo "** New Session **"
}

tmux_running() {
  [[ ! -z $(pgrep tmux) ]]
}

goto_session() {
  session=$1

  if [[ -z ${TMUX} ]]; then
    # We are not inside a tmux session. Attach to selected session.
    tmux attach-session -t $session
  else 
    # We are inside a tmux session, switch to selected session.
    tmux switch-client -t $session
  fi
}

# ---- Main ---- #

if [[ $# == 1 ]]; then
  session=$1
fi

if ! tmux_running; then
  if [[ -z $session ]]; then
    read -p 'New session: ' session
  fi
  tmux new-session -s $session
  exit 0
fi

if [[ -z $session ]]; then
  session=$(available_sessions | selector)
  if [[ -z $session ]]; then
    # If user does not select anything at fzf prompt, just exit.
    exit 0
  fi
  if [[ $session == '** New Session **' ]]; then
    read -p 'New session: ' session
  fi
fi

if ! tmux has-session -t $session 2> /dev/null; then
  tmux new-session -ds $session
fi

goto_session $session

