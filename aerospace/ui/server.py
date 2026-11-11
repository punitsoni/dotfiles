#!/usr/bin/env python3
"""
Tiny local UI for aerospace/assignments.json.

Usage: server.py [port]   (default 8765) -> http://127.0.0.1:8765
Shows app -> workspace assignments, open windows with no assignment,
and lets you add / edit / remove assignments and trigger a reassign.
"""

import json
import os
import subprocess
import sys
from http.server import BaseHTTPRequestHandler, HTTPServer

HERE = os.path.dirname(os.path.realpath(__file__))
AERO = os.path.dirname(HERE)
CONFIG = os.path.join(AERO, "assignments.json")
REASSIGN = os.path.join(AERO, "reassign-windows.py")


def load():
    with open(CONFIG) as f:
        return json.load(f)


def save(cfg):
    tmp = CONFIG + ".tmp"
    with open(tmp, "w") as f:
        json.dump(cfg, f, indent=2)
        f.write("\n")
    os.replace(tmp, CONFIG)


def open_windows():
    r = subprocess.run(
        ["aerospace", "list-windows", "--all", "--format",
         "%{window-id}|%{app-bundle-id}|%{app-name}|%{workspace}|%{window-title}"],
        capture_output=True, text=True,
    )
    if r.returncode != 0:
        return None, r.stderr.strip() or "aerospace not reachable"
    wins = []
    for line in r.stdout.strip().splitlines():
        wid, bid, app, ws, title = (p.strip() for p in line.split("|", 4))
        wins.append({"id": wid, "bundle_id": bid, "app": app, "workspace": ws, "title": title})
    return wins, None


def state():
    cfg = load()
    wins, err = open_windows()
    wins = wins or []
    apps = cfg["apps"]
    for bid, a in apps.items():
        a["open"] = [w for w in wins if w["bundle_id"] == bid]
    unassigned = {}
    for w in wins:
        if w["bundle_id"] not in apps:
            u = unassigned.setdefault(
                w["bundle_id"], {"bundle_id": w["bundle_id"], "name": w["app"], "windows": []})
            u["windows"].append(w)
    return {"default_workspace": cfg["default_workspace"], "apps": apps,
            "unassigned": list(unassigned.values()), "error": err}


class Handler(BaseHTTPRequestHandler):
    def log_message(self, *a):
        pass

    def send(self, code, body, ctype="application/json"):
        data = body if isinstance(body, bytes) else json.dumps(body).encode()
        self.send_response(code)
        self.send_header("Content-Type", ctype)
        self.send_header("Content-Length", str(len(data)))
        self.end_headers()
        self.wfile.write(data)

    def body(self):
        return json.loads(self.rfile.read(int(self.headers.get("Content-Length", 0))) or b"{}")

    def do_GET(self):
        if self.path == "/api/state":
            self.send(200, state())
        elif self.path == "/":
            with open(os.path.join(HERE, "index.html"), "rb") as f:
                self.send(200, f.read(), "text/html; charset=utf-8")
        else:
            self.send(404, {"error": "not found"})

    def do_POST(self):
        b = self.body()
        cfg = load()
        if self.path == "/api/assign":
            bid, ws = b.get("bundle_id", "").strip(), b.get("workspace", "").strip()
            if not bid or not ws:
                return self.send(400, {"error": "bundle_id and workspace required"})
            cfg["apps"][bid] = {"name": b.get("name", "").strip() or bid, "workspace": ws}
        elif self.path == "/api/default":
            ws = b.get("workspace", "").strip()
            if not ws:
                return self.send(400, {"error": "workspace required"})
            cfg["default_workspace"] = ws
        elif self.path == "/api/remove":
            cfg["apps"].pop(b.get("bundle_id", ""), None)
        elif self.path == "/api/reassign":
            subprocess.run([REASSIGN, "--all"])
            return self.send(200, {"ok": True})
        else:
            return self.send(404, {"error": "not found"})
        save(cfg)
        self.send(200, {"ok": True})


if __name__ == "__main__":
    port = int(sys.argv[1]) if len(sys.argv) > 1 else 8765
    print(f"http://127.0.0.1:{port}")
    HTTPServer(("127.0.0.1", port), Handler).serve_forever()
