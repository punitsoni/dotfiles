-- Shared helpers for Python tooling (basedpyright, ruff) to resolve the
-- project's `uv`-managed virtualenv instead of falling back to a global
-- interpreter.
--
-- `uv sync` always creates `.venv` at the project root (the directory
-- containing `pyproject.toml` / `uv.lock`). We walk up from the buffer to
-- find that root, then point the LSP at `.venv/bin/python` if it exists.
-- If `uv sync` hasn't been run yet, `.venv` won't exist and callers should
-- fall back to whatever `basedpyright`/`ruff` picks by default.

local M = {}

-- Finds the nearest ancestor directory containing pyproject.toml or
-- uv.lock, starting from `path` (a file or directory).
function M.find_project_root(path)
  local markers = { 'pyproject.toml', 'uv.lock' }
  local found = vim.fs.find(markers, {
    path = path,
    upward = true,
  })[1]
  if not found then
    return nil
  end
  return vim.fs.dirname(found)
end

-- Returns the absolute path to the project's uv-managed venv python
-- interpreter, or nil if none is found (e.g. `uv sync` hasn't run yet).
function M.find_venv_python(root)
  if not root then
    return nil
  end
  local candidate = root .. '/.venv/bin/python'
  if vim.uv.fs_stat(candidate) then
    return candidate
  end
  return nil
end

return M
