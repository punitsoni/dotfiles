"""HTTP server: homepage at / plus static files from ~/webs/docs at /docs/."""

from __future__ import annotations

import html
import http.server
from pathlib import Path

WEBS_HOME = Path.home() / "webs"
DOCS_DIR = WEBS_HOME / "docs"


def _render_homepage() -> bytes:
    entries = sorted(p.name for p in DOCS_DIR.iterdir()) if DOCS_DIR.is_dir() else []
    items = "\n".join(
        f'    <li><a href="/docs/{html.escape(name)}">{html.escape(name)}</a></li>'
        for name in entries
    ) or "    <li><em>No documents yet — add files to ~/webs/docs</em></li>"
    return f"""<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>webs</title>
  <style>
    body {{ font-family: -apple-system, sans-serif; max-width: 40rem; margin: 3rem auto; padding: 0 1rem; }}
    h1 {{ font-size: 1.4rem; }}
    ul {{ line-height: 1.8; }}
  </style>
</head>
<body>
  <h1>webs</h1>
  <p>Documents served from <code>~/webs/docs</code>:</p>
  <ul>
{items}
  </ul>
</body>
</html>
""".encode("utf-8")


class WebsRequestHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=str(WEBS_HOME), **kwargs)

    def do_GET(self):
        if self.path in ("/", "/index.html"):
            body = _render_homepage()
            self.send_response(200)
            self.send_header("Content-Type", "text/html; charset=utf-8")
            self.send_header("Content-Length", str(len(body)))
            self.end_headers()
            self.wfile.write(body)
            return
        if not self.path.startswith("/docs/") and self.path != "/docs":
            self.send_error(404, "File not found")
            return
        super().do_GET()
