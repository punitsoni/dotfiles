local attach = require 'ps.lsp.attach'
local handlers = require 'ps.lsp.handlers'
local capabilities = require 'ps.lsp.capabilities'
local pyproject = require 'ps.lsp.pyproject'

-- basedpyright — primary Python LSP (hover / go-to-definition / diagnostics
-- / type checking). Linting and formatting are handled by ruff instead
-- (see ps.lsp.ruff); basedpyright's own lint-style diagnostics are
-- suppressed below to avoid duplicate/conflicting reports.
--
-- Root detection: walks up from the buffer looking for pyproject.toml or
-- uv.lock (falls back to setup.py/setup.cfg/.git for older-style repos),
-- so it works for `uv`-managed projects like PEPPy without any
-- project-local override.
--
-- Interpreter: `uv sync` always creates `.venv` at the project root. We
-- point basedpyright's pythonPath at `<root>/.venv/bin/python` so it
-- resolves imports against the project's actual dependency set instead of
-- a global/system Python. If `.venv` doesn't exist yet (uv sync hasn't
-- been run), we warn once and let basedpyright fall back to its own
-- interpreter discovery.
return {
  cmd = { 'basedpyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'uv.lock', 'setup.py', 'setup.cfg', '.git' },
  capabilities = capabilities.get(),
  handlers = handlers.default(),
  on_attach = attach.with_default_config,

  before_init = function(_, config)
    local root = pyproject.find_project_root(config.root_dir) or config.root_dir
    local venv_python = pyproject.find_venv_python(root)
    config.settings = config.settings or {}
    config.settings.python = config.settings.python or {}
    if venv_python then
      config.settings.python.pythonPath = venv_python
    elseif root then
      -- Found a project root but no `.venv` — `uv sync` hasn't run. Nag once.
      -- (When there's no root at all, e.g. a scratch file, stay silent and let
      -- basedpyright discover its own interpreter.)
      vim.schedule(function()
        vim.notify(
          'basedpyright: no .venv at ' .. root .. ' — run `uv sync` first',
          vim.log.levels.WARN
        )
      end)
    end
  end,

  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = 'standard',
        -- ruff owns unused-import/unused-variable style diagnostics; avoid
        -- basedpyright duplicating them.
        diagnosticSeverityOverrides = {
          reportUnusedImport = 'none',
          reportUnusedVariable = 'none',
        },
      },
    },
  },
}
