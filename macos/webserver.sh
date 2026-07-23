#!/usr/bin/env bash
## Serves ~/web as static files. Invoked by com.local.webserver launchd job.
set -eu

PORT="${WEBSERVER_PORT:-8080}"
WEB_DIR="${HOME}/web"

mkdir -p "$WEB_DIR"
cd "$WEB_DIR"

exec /usr/bin/python3 -m http.server "$PORT" --bind 0.0.0.0
