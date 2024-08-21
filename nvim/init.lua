-- Load my global functions / objects.
require 'ps.globals'
-- Configure default neovim setup such as options.
require 'ps.general'
-- Setup plugins via lazy.nvim.
require 'ps.golazy'
-- Configure custom keymaps.
require 'ps.keymaps'
-- Enable actions.
require 'ps.actions'
-- Custom Interactions --
require 'ps.interaction'
-- Experimental config.
require 'ps.experiments'

-- Set colorscheme.
-- local colorscheme = 'onedark'
-- local colorscheme = 'catppuccin-frappe'
local colorscheme = 'catppuccin'
-- local colorscheme = 'rose-pine-main'

vim.cmd('silent! colorscheme ' .. colorscheme)


--- Experimentation ----

-- vim.lsp.set_log_level('WARN')


