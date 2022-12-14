require 'ps.general'
require 'ps.plugins'
require 'ps.keymaps'

require 'ps.config_telescope'

-- Load basic actions
require 'ps.actions'

-- Set colorscheme
vim.cmd 'silent! colorscheme sonokai'

-- EXPERIMENTATION --

require'lualine'.setup {}

-- local lsp_install = require 'lspinstall'

--lsp_util = require 'lsp_util'
-- lsp_util.install_ls('lua')

-- print('starting profile')
-- require('plenary.profile').start('/tmp/output_flame.log', {flame = true})
