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
