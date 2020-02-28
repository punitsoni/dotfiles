#!/bin/sh

export XSECURELOCK_AUTH_FOREGROUND_COLOR=green
# export XSECURELOCK_FONT=monospace:size=20
export XSECURELOCK_PASSWORD_PROMPT=time_hex
export XSECURELOCK_BLANK_TIMEOUT=-1
export XSECURELOCK_SAVER=saver_xscreensaver

exec /usr/share/goobuntu-desktop-files/xsecurelock.sh

# xsecurelock
