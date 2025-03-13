-- Neovide GUI config
require 'ps.neovide'
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

-- Set colorscheme.
-- local colorscheme = 'onedark'
-- local colorscheme = 'catppuccin-frappe'
-- local colorscheme = 'catppuccin-macchiato'
local colorscheme = 'catppuccin-mocha'
-- local colorscheme = 'catppuccin'
-- local colorscheme = 'rose-pine-main'

vim.cmd('silent! colorscheme ' .. colorscheme)


--- Experimentation ----

-- vim.lsp.set_log_level('WARN')

vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m"



