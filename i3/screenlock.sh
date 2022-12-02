#!/bin/sh

# Color is based on X11 color names. See https://en.wikipedia.org/wiki/X11_color_names
export XSECURELOCK_AUTH_FOREGROUND_COLOR="Lime Green"
export XSECURELOCK_FONT=monospace:size=20
export XSECURELOCK_FONT="Press Start 2P:size=20:Style=Regular"
export XSECURELOCK_PASSWORD_PROMPT=time_hex
export XSECURELOCK_BLANK_TIMEOUT=-1
export XSECURELOCK_SAVER=saver_xscreensaver
export XSECURELOCK_SHOW_DATETIME=0
export XSECURELOCK_SHOW_HOSTNAME=0

exec /usr/share/goobuntu-desktop-files/xsecurelock.sh

# xsecurelock
