-- Neovide GUI config
require 'ps.neovide'
-- Configure default neovim setup such as options.
require 'ps.general'
-- Setup plugins via lazy.nvim.
require 'ps.golazy'
-- Configure LSP servers.
require 'ps.lsp'
-- Configure custom keymaps.
require 'ps.keymaps'
-- Enable actions.
require 'ps.actions'
-- Custom Interactions --
require 'ps.interaction'

-- Set colorscheme.
local colorscheme = 'ayu-mirage'
-- local colorscheme = 'onedark'
-- local colorscheme = 'catppuccin-frappe'
-- local colorscheme = 'catppuccin-macchiato'
-- local colorscheme = 'catppuccin-mocha'
-- local colorscheme = 'catppuccin'
-- local colorscheme = 'rose-pine-main'

vim.cmd('silent! colorscheme ' .. colorscheme)

-- Make Snacks picker directory paths more readable (ayu NonText is too faint).
vim.api.nvim_set_hl(0, 'SnacksPickerDir', { link = 'Comment' })

--- Experimentation ----

-- vim.lsp.set_log_level('WARN')

vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m"
