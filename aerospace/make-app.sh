#!/usr/bin/env bash
# Builds a double-clickable "AeroSpace Workspaces.app" in ~/Applications that runs workspaces-ui.sh.
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"
APP="${HOME}/Applications/AeroSpace Workspaces.app"
mkdir -p "${HOME}/Applications"
rm -rf "$APP"
osacompile -o "$APP" -e "do shell script \"'${DIR}/workspaces-ui.sh' >/dev/null 2>&1 &\""
echo "Built $APP"
