-- Configure default neovim setup such as options.
require 'ps.general'
-- Load and configure external plugins.
require 'ps.plugins'
require 'ps.config_plugins'
-- Configure custom keymaps.
require 'ps.keymaps'
-- Enable actions.
require 'ps.actions'

-- Set colorscheme.
-- vim.cmd 'silent! colorscheme sonokai'

vim.cmd 'silent! colorscheme rose-pine'

-- EXPERIMENTATION --

-- require 'ps.wsp'

-- print('starting profile')
-- require('plenary.profile').start('/tmp/output_flame.log', {flame = true})

