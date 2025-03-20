local function config__mason()
  require 'mason'.setup()
  require 'mason-lspconfig'.setup {
    -- ensure_installed = { 'lua_ls', 'bashls', 'basedpyright' },
    -- LSP servers setup via lspconfig are automatically installed.
    ensure_installed = {},
    automatic_installation = true,
  }
end

-- Return the Lazy plugin spec. --
return {
  { 'williamboman/mason.nvim' },
  {
    'williamboman/mason-lspconfig.nvim',
    config = config__mason,
  },
}
