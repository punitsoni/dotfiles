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
local colorscheme = 'onedark'
-- local colorscheme = 'rose-pine-main'

vim.cmd('silent! colorscheme ' .. colorscheme)

-- Load any local config that is not part of this github repo.
-- e.g. work related stuff.
-- require 'ps.local'

-- EXPERIMENTATION --

-- require 'ps.wsp'

-- print('starting profile')
-- require('plenary.profile').start('/tmp/output_flame.log', {flame = true})

-- vim.lsp.set_log_level('trace')

