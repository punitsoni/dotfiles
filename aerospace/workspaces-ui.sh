#!/usr/bin/env bash
# Open the workspace-assignment UI in its own app window (starts the server if needed).
# If the window is already open, raise it instead of opening another.
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"   # also set when launched from the .app
DIR="$(cd "$(dirname "$(readlink -f "$0" 2>/dev/null || echo "$0")")" && pwd)"
PORT=8765
URL="http://127.0.0.1:${PORT}"
WIDTH=902 HEIGHT=744

if ! nc -z 127.0.0.1 "$PORT" 2>/dev/null; then
    nohup python3 "$DIR/ui/server.py" "$PORT" >/tmp/aerospace-ui.log 2>&1 &
    for _ in {1..20}; do nc -z 127.0.0.1 "$PORT" 2>/dev/null && break; sleep 0.2; done
fi

# Needs macOS Automation permission for the browser (prompted on first run).
# $1 = app, $2 = "raise" | "resize". Prints "ok" if a window at $URL was found.
with_window() {
    pgrep -x "$1" >/dev/null || return 1
    osascript 2>/dev/null <<OSA
tell application "$1"
    repeat with w in windows
        if (URL of active tab of w) starts with "$URL" then
            if "$2" is "raise" then
                set index of w to 1
                activate
            else
                set b to bounds of w
                set bounds of w to {item 1 of b, item 2 of b, (item 1 of b) + $WIDTH, (item 2 of b) + $HEIGHT}
            end if
            return "ok"
        end if
    end repeat
end tell
return "none"
OSA
}

# Chromium --app mode = frameless window, no tabs / URL bar.
for app in "Brave Browser" "Google Chrome"; do
    [[ -d "/Applications/${app}.app" ]] || continue
    [[ "$(with_window "$app" raise)" == "ok" ]] && exit 0
    open -na "$app" --args --app="$URL" --window-size="$WIDTH,$HEIGHT"
    # Chromium restores the last window size over --window-size, so set it explicitly.
    for _ in {1..25}; do
        [[ "$(with_window "$app" resize)" == "ok" ]] && break
        sleep 0.2
    done
    exit 0
done
exec open "$URL"
