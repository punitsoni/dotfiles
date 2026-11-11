#!/usr/bin/env python3
"""
Moves windows to their assigned workspaces.

Usage:
    reassign-windows.py              # single window (on-window-detected, uses AEROSPACE_WINDOW_ID)
    reassign-windows.py --all        # all open windows (startup / manual)
"""

import json
import os
import subprocess
import sys

# Assignments live in assignments.json (editable via ui/server.py).
CONFIG = os.path.join(os.path.dirname(os.path.realpath(__file__)), "assignments.json")


def load_config():
    with open(CONFIG) as f:
        cfg = json.load(f)
    apps = {bid: a["workspace"] for bid, a in cfg["apps"].items()}
    return apps, cfg["default_workspace"]


WORKSPACE_FOR_APP, DEFAULT_WORKSPACE = load_config()


def notify(message, title="AeroSpace"):
    subprocess.run(
        ["osascript", "-e", f'display notification "{message}" with title "{title}"']
    )


def move_window(window_id, app_id):
    ws = WORKSPACE_FOR_APP.get(app_id, DEFAULT_WORKSPACE)
    subprocess.run(["aerospace", "move-node-to-workspace", ws, "--window-id", window_id])
    if ws == DEFAULT_WORKSPACE:
        subprocess.run(["aerospace", "layout", "floating", "--window-id", window_id])
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
