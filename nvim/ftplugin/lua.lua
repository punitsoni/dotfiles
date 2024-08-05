-- Configuration for filetype lua.

-- Use spaces instead of tabs.
vim.opt.expandtab = true
-- Set default indentation size.
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.shiftround = true

-- Run current file.
local function run_current_file()
  print('Running current lua file')
  vim.cmd('luafile %')
end
vim.keymap.set('n', '<space>r.', run_current_file, {})

