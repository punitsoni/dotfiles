# echo to stderr
perr() {
  echo "$1" >&2
}

logv() {
  if [[ "${FLAG_verbose}" == "true" ]]; then
    perr "$1"
  fi
}

die() {
  if [[ -n $1 ]]; then
    perr "Error: $1"
  fi
  exit 1
}

