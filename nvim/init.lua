-- Load my global functions / objects.
require 'ps.globals'
-- Configure default neovim setup such as options.
require 'ps.general'
-- Setup plugins via lazy.nvim.
require 'ps.lazy_plugins'
-- Configure custom keymaps.
require 'ps.keymaps'
-- Enable actions.
require 'ps.actions'

-- Set colorscheme.
-- vim.cmd 'silent! colorscheme sonokai'
vim.cmd 'silent! colorscheme rose-pine'
-- vim.cmd 'silent! colorscheme gruvbox'

-- Load any local config that is not part of this github repo.
-- e.g. work related stuff.
-- require 'ps.local'

-- EXPERIMENTATION --

require 'ps.wsp'

-- print('starting profile')
-- require('plenary.profile').start('/tmp/output_flame.log', {flame = true})

