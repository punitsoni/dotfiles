local function config__nvim_lspconfig()
  vim.lsp.set_log_level('debug')
  -- Configure language servers.
  require("lspconfig").lua_ls.setup(require 'ps.lsp.lua_ls')
  require("lspconfig").clangd.setup(require 'ps.lsp.clangd')
  -- require("lspconfig").basedpyright.setup(require 'ps.lsp.basedpyright')
  require("lspconfig").bashls.setup(require 'ps.lsp.bashls')
  require("lspconfig").pylsp.setup(require 'ps.lsp.pylsp')
end


-- Return the Lazy plugin spec. --
return {
  {
    'neovim/nvim-lspconfig',
    config = config__nvim_lspconfig,
    dependencies = {
      -- Mason insures that language servers are installed.
      { 'williamboman/mason-lspconfig.nvim' },
      -- Cmp provides completion engine that is used by lspconfig.
      { 'hrsh7th/nvim-cmp' },
    },
  },

}
