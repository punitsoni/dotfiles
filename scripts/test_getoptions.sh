#!/usr/bin/env bash

source $DOTFILES/scripts/getoptions.sh


parser_definition() {
  setup   REST help:usage -- "Usage: example.sh [options]... [arguments]..." ''
  msg -- 'Options:'
  flag    FLAG    -f --flag                 -- "takes no arguments"
  param   PARAM   -p --param                -- "takes one argument"
  option  OPTION  -o --option on:"default"  -- "takes one optional argument"
  disp    :usage  -h --help
  disp    VERSION    --version
}

eval "$(getoptions parser_definition) exit 1"

echo "FLAG: $FLAG, PARAM: $PARAM, OPTION: $OPTION"

# Positional arguments.
args=$@

# cmd=${args[0]}
cmd=$1

echo cmd=$cmd



