-- Configure default neovim setup such as options.
require 'ps.general'
-- Setup plugins via lazy.nvim.
require 'ps.plugins'
-- Configure custom keymaps.
require 'ps.keymaps'
-- Enable actions.
require 'ps.actions'
-- Load my global functions / objects.
require 'ps.globals'


-- Set colorscheme.
-- local colorscheme = 'onedark'
local colorscheme = 'catppuccin'
-- local colorscheme = 'rose-pine-main'

vim.cmd('silent! colorscheme ' .. colorscheme)

-- EXPERIMENTATION --

require 'ps.wsp'

