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

# ssh with automatic reconnection
cmd::sshme() { (
  set -x
  autossh -M 0 -o "ServerAliveInterval 60" -o "ServerAliveCountMax 5" "$@"
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
