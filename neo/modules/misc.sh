# Displays weather in your current location.
cmd::weather() {
  echo ""
  curl "wttr.in?q0uFnM"
  echo ""
}

# Tells a random chuck joke.
# TODO: This api seems to be broken. Investigate.
# cmd::chuck() {
#   wget "http://api.icndb.com/jokes/random" -qO-
#     jshon -e value -e joke -u | recode html | cowsay | lolcat
# }

# ssh with automatic reconnection (autossh), tuned for a laptop that
# frequently sleeps (lid-close) and roams between networks.
#
# Usage:
#   neo sshme <host> [ssh-args...]  connect, auto-reconnecting on drop;
#                                   everything after <host> is forwarded to
#                                   ssh (e.g. -L 8080:localhost:80 tunnel)
#   neo sshme zm <host> list        list remote zellij sessions (one-shot)
#   neo sshme zm <host> <name>      attach to (or create) a remote zellij
#                                   session, surviving sleep/roam reconnects
#
# Notes:
#   - autossh keepalives detect a dead link in ~20s and rebuild it.
#   - `zm list` uses plain ssh, not autossh, since a one-shot command
#     would otherwise be loop-restarted by autossh.
#   - remote zellij commands run in a plain (non-login, non-interactive)
#     shell, so zellij must be on PATH there (e.g. exported from .zshenv).
cmd::sshme() { (

  # Tuned for a laptop that frequently sleeps (lid-close) and roams networks.
  # GATETIME=0 stops autossh from giving up when the first post-wake
  # reconnect dies instantly; keepalives detect the dead link in ~20s.
  export AUTOSSH_GATETIME=0 AUTOSSH_POLL=20
  local -a autossh_opts=(
    -M 0
    -o "ServerAliveInterval 10"
    -o "ServerAliveCountMax 2"
    -o "ExitOnForwardFailure yes"
    -o "ConnectTimeout 8"
    -o "TCPKeepAlive no"
    -o "IPQoS throughput"
  )

  # zm subcommand (precedes host): manage a remote zellij session.
  if [[ "$1" == "zm" ]]; then
    shift
    local host="$1"; shift
    if [[ "$1" == "list" || "$1" == "--list" || "$1" == "-l" ]]; then
      # one-shot listing: plain ssh, not autossh (which would loop-restart)
      ssh "$host" "zellij list-sessions"
      exit
    fi
    if [[ -z "$1" ]]; then
      echo "usage: neo sshme zm <host> <session-name> | list" >&2
      exit 1
    fi
    autossh "${autossh_opts[@]}" -t "$host" "zellij attach --create $1"
    exit
  fi

  # default: forward all args (host + ssh options/command) verbatim
  autossh "${autossh_opts[@]}" "$@"

); }

# Checkout git branch using fzf
cmd::gch_fzf() {
  # branches=$(git branch | grep -v HEAD)
  # preview_cmd='git log --oneline --graph --date=short --color=always --pretty=format:"%C(auto)%cd %h%d %s"'
  # branch=$(git branch |
  #   fzf-tmux --height 40% --reverse --multi --preview-window right:65% \
  #     --preview \'${preview_cmd}\' cut -d' ' -f3 |
  #   sed 's#remotes/[^/]*/##')
  branch_list=$(git branch --list --format='%(refname:short)')
  branch=$( \
    echo "$branch_list" \
    | fzf --height=40% --reverse \
  )
  echo "checking out: $branch"
  git checkout "$branch"
}

# Remove all "gone" branches.
cmd::git_gone() {
  git fetch --all --prune && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D;
}
