"""CLI for the webs static file server.

Commands:
  webs run [--port PORT]      Run the server in the foreground.
  webs install [--port PORT]  Install/reload a launchd agent that runs it in the background.
  webs uninstall               Stop and remove the launchd agent.
"""

from __future__ import annotations

import http.server
import os
import shutil
import subprocess
import sys
from pathlib import Path

import typer

from .server import DOCS_DIR, WEBS_HOME, WebsRequestHandler

DEFAULT_PORT = 8080
LABEL = "com.local.webserver"
PLIST_PATH = Path.home() / "Library" / "LaunchAgents" / f"{LABEL}.plist"
LOG_DIR = Path.home() / "Library" / "Logs"

app = typer.Typer(no_args_is_help=True, add_completion=False)


@app.command()
def run(port: int = typer.Option(DEFAULT_PORT, "--port", help="Port to listen on")) -> None:
    """Run the server in the foreground."""
    DOCS_DIR.mkdir(parents=True, exist_ok=True)
    server = http.server.ThreadingHTTPServer(("0.0.0.0", port), WebsRequestHandler)
    print(f"Serving {WEBS_HOME} (docs at {DOCS_DIR}) on http://0.0.0.0:{port}")
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        server.shutdown()


def _require(cmd: str) -> str:
    path = shutil.which(cmd)
    if path is None:
        print(f"Error: '{cmd}' not found on PATH.", file=sys.stderr)
        raise typer.Exit(1)
    return path


def _plist_contents(port: int) -> str:
    uv_path = _require("uv")
    project_dir = Path(__file__).resolve().parents[2]
    LOG_DIR.mkdir(parents=True, exist_ok=True)
    return f"""<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>{LABEL}</string>
    <key>ProgramArguments</key>
    <array>
        <string>{uv_path}</string>
        <string>run</string>
        <string>--project</string>
        <string>{project_dir}</string>
        <string>webs</string>
        <string>run</string>
        <string>--port</string>
        <string>{port}</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>StandardOutPath</key>
    <string>{LOG_DIR}/webserver.out.log</string>
    <key>StandardErrorPath</key>
    <string>{LOG_DIR}/webserver.err.log</string>
</dict>
</plist>
"""


@app.command()
def install(port: int = typer.Option(DEFAULT_PORT, "--port", help="Port to listen on")) -> None:
    """Install/reload a launchd agent running the server in the background."""
    DOCS_DIR.mkdir(parents=True, exist_ok=True)
    PLIST_PATH.parent.mkdir(parents=True, exist_ok=True)

    already_loaded = (
        subprocess.run(["launchctl", "list", LABEL], capture_output=True).returncode == 0
    )
    if already_loaded:
        subprocess.run(["launchctl", "unload", str(PLIST_PATH)], check=False)

    PLIST_PATH.write_text(_plist_contents(port))
    subprocess.run(["launchctl", "load", str(PLIST_PATH)], check=True)

    action = "Reloaded" if already_loaded else "Installed"
    print(f"{action}. Serving {DOCS_DIR} on http://0.0.0.0:{port}")
    print(f"Logs: {LOG_DIR}/webserver.{{out,err}}.log")
    print(f"Stop:    launchctl unload {PLIST_PATH}")
    print(f"Restart: launchctl kickstart -k gui/{os.getuid()}/{LABEL}")


@app.command()
def uninstall() -> None:
    """Stop and remove the launchd agent."""
    if PLIST_PATH.exists():
        subprocess.run(["launchctl", "unload", str(PLIST_PATH)], check=False)
        PLIST_PATH.unlink()
        print(f"Uninstalled {LABEL}.")
    else:
        print("Not installed.")


def main() -> None:
    app()


if __name__ == "__main__":
    main()
