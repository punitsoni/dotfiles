# Library of bash functions.

# Jupyter QtConsole with configuration
jqt() {
  nohup jupyter qtconsole --no-confirm-exit --paging vsplit \
    --JupyterWidget.font_size=12 1>&2 > /dev/null &
  echo "Jupyter QtConsole started."
}

# open a file in desktop UI
xo() {
  xdg-open $1
}

# Show $PATH variable with each entry in its own line.
showpath() {
  sed 's/:/\n/g' <<< "$PATH"
}

random_chuck_joke() {
  wget "http://api.icndb.com/jokes/random" -qO- | \
    jshon -e value -e joke -u | recode html | cowsay | lolcat
}

weather() {
  city=$(curl ifconfig.co/city 2> /dev/null)
  echo "Weather in $city at $(date)"
  curl wttr.in/"$city"?Q0Fn
}
