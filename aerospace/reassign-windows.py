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
    "com.apple.dt.Xcode": "4",
    "com.googlecode.iterm2": "3",
    "com.microsoft.VSCode": "6",
    "com.apple.MobileSMS": "9",
    "com.apple.iCal": "Q",
    "com.logseq.logseq": "E",
    "com.apple.radar.gm": "R",
    "com.apple.mail": "M",
    "com.tinyspeck.slackmacgap": "S",
    "Cisco-Systems.Spark": "W",
}

# Windows whose app isn't in the map above go here.
DEFAULT_WORKSPACE = "8"


def notify(message, title="AeroSpace"):
    subprocess.run(
        ["osascript", "-e", f'display notification "{message}" with title "{title}"']
    )


def move_window(window_id, app_id):
    ws = WORKSPACE_FOR_APP.get(app_id, DEFAULT_WORKSPACE)
    subprocess.run(["aerospace", "move-node-to-workspace", ws, "--window-id", window_id])
    return ws


def focused_window_id():
    result = subprocess.run(
        ["aerospace", "list-windows", "--focused", "--format", "%{window-id}"],
        capture_output=True, text=True,
    )
    return result.stdout.strip() or None


def move_all():
    focused = focused_window_id()
    result = subprocess.run(
        ["aerospace", "list-windows", "--all", "--format", "%{window-id}|%{app-bundle-id}"],
        capture_output=True, text=True,
    )
    moved = 0
    focused_ws = None
    for line in result.stdout.strip().splitlines():
        wid, app_id = line.split("|", 1)
        wid = wid.strip()
        ws = move_window(wid, app_id.strip())
        moved += 1
        if wid == focused:
            focused_ws = ws
    notify(f"Reassigned {moved} window(s) to pinned workspaces")
    # Follow the previously-focused window to wherever it landed.
    if focused_ws:
        subprocess.run(["aerospace", "workspace", focused_ws])


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
