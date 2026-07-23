#!/usr/bin/env bash
## Installs the static file webserver as a launchd agent, serving ~/web on port 7000.
set -euo pipefail

if [[ -z "${DOTFILES:-}" || ! -d "$DOTFILES" ]]; then
    echo "Error: \$DOTFILES is not set or does not exist." >&2
    exit 1
fi

PLIST_SRC="${DOTFILES}/macos/com.local.webserver.plist"
PLIST_DST="${HOME}/Library/LaunchAgents/com.local.webserver.plist"

mkdir -p "${HOME}/web"
mkdir -p "${HOME}/Library/LaunchAgents"

sed -e "s|__DOTFILES__|${DOTFILES}|g" -e "s|__HOME__|${HOME}|g" "$PLIST_SRC" > "$PLIST_DST"

launchctl unload "$PLIST_DST" 2>/dev/null || true
launchctl load "$PLIST_DST"

echo "Installed. Serving ${HOME}/web on http://0.0.0.0:8080"
echo "Logs: ${HOME}/Library/Logs/webserver.{out,err}.log"
echo "Stop:    launchctl unload ${PLIST_DST}"
echo "Restart: launchctl kickstart -k gui/$(id -u)/com.local.webserver"
