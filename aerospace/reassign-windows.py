#!/usr/bin/env python3
"""
Moves windows to their assigned workspaces.

Usage:
    reassign-windows.py              # single window (on-window-detected, uses AEROSPACE_WINDOW_ID)
    reassign-windows.py --all        # all open windows (startup / manual)
"""

import os
import subprocess
import sys

WORKSPACE_FOR_APP = {
    "com.brave.Browser": "1",
    "com.apple.Safari": "2",
    "com.apple.dt.Xcode": "3",
    "com.googlecode.iterm2": "5",
    "com.microsoft.VSCode": "6",
    "com.apple.MobileSMS": "9",
    "com.apple.iCal": "Q",
    "com.logseq.logseq": "E",
    "com.apple.radar.gm": "R",
    "com.apple.mail": "M",
    "com.tinyspeck.slackmacgap": "S",
    "Cisco-Systems.Spark": "W",
}


def move_window(window_id, app_id):
    ws = WORKSPACE_FOR_APP.get(app_id)
    if ws:
        subprocess.run(["aerospace", "move-node-to-workspace", ws, "--window-id", window_id])


def move_all():
    result = subprocess.run(
        ["aerospace", "list-windows", "--all", "--format", "%{window-id}|%{app-bundle-id}"],
        capture_output=True, text=True,
    )
    for line in result.stdout.strip().splitlines():
        wid, app_id = line.split("|", 1)
        move_window(wid.strip(), app_id.strip())


def move_single():
    window_id = os.environ.get("AEROSPACE_WINDOW_ID")
    if not window_id:
        print("AEROSPACE_WINDOW_ID not set. Use --all for manual mode.", file=sys.stderr)
        sys.exit(1)
    result = subprocess.run(
        ["aerospace", "list-windows", "--format", "%{app-bundle-id}", "--window-id", window_id],
        capture_output=True, text=True,
    )
    app_id = result.stdout.strip()
    move_window(window_id, app_id)


if __name__ == "__main__":
    if "--all" in sys.argv:
        move_all()
    else:
        move_single()
