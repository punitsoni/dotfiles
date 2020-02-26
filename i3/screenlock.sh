#!/bin/sh

export XSECURELOCK_AUTH_FOREGROUND_COLOR=green
export XSECURELOCK_FONT=monospace:size=20
export XSECURELOCK_PASSWORD_PROMPT=time_hex
exec xsecurelock
