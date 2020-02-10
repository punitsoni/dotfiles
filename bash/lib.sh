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

# Displays weather in your city. If data is not available in certain time, it
# times out and does not print anything.
maybe_weather() {
  timeout="1.0s"
  # city=$(timeout $timeout curl --silent ifconfig.co/city) && \
  # w=$(timeout $timeout curl --silent wttr.in/"$city"?Q0uFnM) && \
  # echo "Weather in $city. $(date +%A\ %x\ %r)" && \
  # echo "$w"
  timeout $timeout curl wttr.in?q0uFnM
}

