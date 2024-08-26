local function SetupLspConfig()
  local capabilities = require 'ps.lsp.capabilities'
  -- nvim-cmp supports additional completion capabilities.
  local new_caps = require 'cmp_nvim_lsp'.default_capabilities(
    capabilities.get()
  )
  capabilities.update(new_caps)

  require 'mason'.setup()
  require 'mason-lspconfig'.setup {
    ensure_installed = { 'lua_ls', 'bashls' },
  }

  -- Configure language servers.
  require("lspconfig").lua_ls.setup(require 'ps.lsp.lua_ls')
  require("lspconfig").clangd.setup(require 'ps.lsp.clangd')
  require("lspconfig").pyright.setup(require 'ps.lsp.pyright')
  require("lspconfig").bashls.setup(require 'ps.lsp.bashls')
end


local function SetupNvimCmp()
  local cmp = require 'cmp'
  cmp.setup {
    mapping = cmp.mapping.preset.insert {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete({}),
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
          -- elseif luasnip.expand_or_jumpable() then
          --   luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
          -- elseif luasnip.jumpable(-1) then
          --   luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    },
    sources = {
      { name = 'nvim_lsp' },
    },
  }
end

-- Return the Lazy plugin spec. --
return {
  {
    'neovim/nvim-lspconfig',
    config = SetupLspConfig,
    dependencies = {
      -- Mason insures that language servers are installed.
      { 'williamboman/mason-lspconfig.nvim' },
      { 'williamboman/mason.nvim' },
      -- Cmp provides completion engine that is used by lspconfig.
      {
        'hrsh7th/nvim-cmp',
        config = SetupNvimCmp,
        dependencies = {
          'hrsh7th/cmp-nvim-lsp',
          'hrsh7th/cmp-nvim-lua',
          'hrsh7th/cmp-buffer',
          'hrsh7th/cmp-path',
          'hrsh7th/cmp-cmdline',
        },
      },
    },
  },

  -- Useful status updates for LSP
  -- Not needed when using noice.
  -- { 'j-hui/fidget.nvim' },

  -- Good LSP settings for neovim lua development.
  {
    "folke/lazydev.nvim",
    ft = "lua",     -- only load on lua files
    opts = {}
  },
  {
    'p00f/clangd_extensions.nvim',
    opts = {},
  },
}
