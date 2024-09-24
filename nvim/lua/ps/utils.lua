local M = {}

-- Removes newline char from a string.
function M.strip(s)
  return string.gsub(s, '\n', '')
end

M.hascmd = function(cmd)
  return vim.fn.exists(cmd) == 2
end

-- Converts a path that is relative to refdir to absolute path.
function M.abspath(refdir, relpath)
  return M.strip(vim.fn.system(
    'cd ' .. refdir .. ' && realpath ' .. relpath))
end

local function keymap(mode, lhs, rhs, opts)
  opts = opts or {}
  opts = vim.tbl_extend('force', opts, { noremap = true })
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Shorthand function for keymappings.
M.nmap = function(lhs, rhs, opts)
  keymap('n', lhs, rhs, opts)
end

M.vmap = function(lhs, rhs, opts)
  keymap('v', lhs, rhs, opts)
end

M.imap = function(lhs, rhs, opts)
  keymap('i', lhs, rhs, opts)
end

M.tmap = function(lhs, rhs, opts)
  keymap('t', lhs, rhs, opts)
end

-- Copies the string s to system clipboard.
M.copy_to_clipboard = function(s)
  -- Write string into vim register `+` which represents the system
  -- clipboard.
  vim.fn.setreg('+', s)
end

-- Returns true if neovim is running inside tmux.
M.running_inside_tmux = function()
  return vim.fn.exists('$TMUX')
end

return M
