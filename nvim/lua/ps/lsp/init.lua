-- LSP configuration using vim.lsp.config API (Neovim 0.11+)

-- Configure language servers
vim.lsp.config.lua_ls = require 'ps.lsp.lua_ls'
vim.lsp.config.clangd = require 'ps.lsp.clangd'
-- vim.lsp.config.basedpyright = require 'ps.lsp.basedpyright'
vim.lsp.config.bashls = require 'ps.lsp.bashls'
vim.lsp.config.pylsp = require 'ps.lsp.pylsp'

-- Enable the LSP servers
vim.lsp.enable('lua_ls')
vim.lsp.enable('clangd')
-- vim.lsp.enable('basedpyright')
vim.lsp.enable('bashls')
vim.lsp.enable('pylsp')
