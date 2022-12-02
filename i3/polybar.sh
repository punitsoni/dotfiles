#!/bin/bash

# killall polybar
polybar-msg cmd quit

# disp_left=DisplayPort-2
# disp_right=DisplayPort-3

disp_left=$1
disp_left=$2

logfile1=/tmp/polybar1.log
# logfile1=/dev/stdout
logfile2=/tmp/polybar2.log

# echo "---" | tee -a $logfile1 $logfile2

MONITOR=${disp_left} polybar \
  --config=${HOME}/.config/i3/polybar_config.ini \
  main > ${logfile1} 2>&1 & disown

MONITOR=${disp_right} polybar \
  --config=${HOME}/.config/i3/polybar_config.ini \
  main > ${logfile2} 2>&1 & disown

