-- Load my global functions / objects.
require 'ps.globals'
-- Configure default neovim setup such as options.
require 'ps.general'
-- Load and configure external plugins.
require 'ps.plugins'
-- Configure custom keymaps.
require 'ps.keymaps'
-- Enable actions.
require 'ps.actions'

-- Set colorscheme.
vim.cmd 'silent! colorscheme sonokai'
-- vim.cmd 'silent! colorscheme rose-pine'
-- vim.cmd 'silent! colorscheme gruvbox'

-- EXPERIMENTATION --

require 'ps.wsp'

-- vim.api.nvim_create_autocmd('VimEnter', {
--   callback = function(ev)
--     vim.cmd 'silent! colorscheme rose-pine'
--   end
-- })

-- print('starting profile')
-- require('plenary.profile').start('/tmp/output_flame.log', {flame = true})

