# Library of shell functions.

# Attach to tmux session. Create new session if it does not exist.
# If no argument provided. It attaches to session 0.
tm() {
  if [ -z $1 ]; then
    ${TMUX_BIN:-tmux} new-session -A -s 0
  else
    ${TMUX_BIN:-tmux} new-session -A -s $1
  fi
}

# Set terminal cursor shape.
cursor() {
  if [[ $1 == "block" ]]; then
      # Set terminal cursor to block.
      echo -ne '\e[2 q'
  else
      # Default: Set terminal cursor to I-beam.
      echo -ne '\e[6 q'
  fi
}

# Run jupyter QtConsole with configuration.
jqt() {
  nohup jupyter qtconsole --no-confirm-exit --paging vsplit \
    --JupyterWidget.font_size=12 1>&2 > /dev/null &
  echo "Jupyter QtConsole started."
}

# Run a command completely detached from terminal.
run_detached() {
  nohup "$@" < /dev/null > /dev/null 2>&1
}

# Open a file in desktop UI.
xo() {
  run_detached xdg-open $1
}

# Show $PATH variable with each entry in its own line.
showpath() {
  # sed 's/:/\n/g' << echo ${PATH}
}

random_chuck_joke() {
  wget "http://api.icndb.com/jokes/random" -qO- | \
    jshon -e value -e joke -u | recode html | cowsay | lolcat
}

# Displays weather in your city.
weather() {
  curl "wttr.in?q0uFnM"
}

