-- Load my global functions / objects.
require 'ps.globals'
-- Configure default neovim setup such as options.
require 'ps.general'
-- Setup plugins via lazy.nvim.
require 'ps.lazy_init'
-- Configure custom keymaps.
require 'ps.keymaps'
-- Enable actions.
require 'ps.actions'

-- Set colorscheme.
-- local colorscheme = 'onedark'
-- local colorscheme = 'catppuccin'
-- local colorscheme = 'rose-pine-main'

-- vim.cmd('silent! colorscheme ' .. colorscheme)

-- EXPERIMENTATION --

require 'ps.wsp'

