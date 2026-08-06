local attach = require 'ps.lsp.attach'
local handlers = require 'ps.lsp.handlers'
local capabilities = require 'ps.lsp.capabilities'

-- ruff — linting (and format-on-save via vim.lsp.buf.format, see keymap.lua
-- <leader>uf) for Python. Reads [tool.ruff] from pyproject.toml natively, so
-- no per-project settings are needed here even though PEPPy doesn't
-- currently define a [tool.ruff] block (ruff just uses its defaults).
return {
  cmd = { 'ruff', 'server' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', 'uv.lock', '.git' },
  capabilities = capabilities.get(),
  handlers = handlers.default(),
  on_attach = function(client, bufnr)
    attach.with_default_config(client, bufnr)
    -- basedpyright is the hover/definition source; ruff only lints/fixes.
    client.server_capabilities.hoverProvider = false
  end,
}
