-- Configuration for filetype lua.

-- Run current file.
local function run_current_file()
  print('Running current lua file')
  vim.cmd('luafile %')
end
vim.keymap.set('n', '<space>r.', run_current_file, {})

