-- Bootstrap lazy.nvim --
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Toggle code-commenting
  'tpope/vim-commentary',
  -- Quotes.
  'tpope/vim-surround',
  -- Telescope fuzzy-finder.
  {
    'nvim-telescope/telescope.nvim',
    -- tag = '0.1.0',
    dependencies = {'nvim-lua/plenary.nvim'},
  },
  -- Native fuzzy finder for telescope. Requires building.
  -- TODO: make sure gcc/clang and make is available.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make'
  },
  -- Treesitter: Highlight, edit and navigate code.
  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      require('nvim-treesitter.install').update({ with_sync = true })()
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function() require'ps.config_treesitter' end,
  },

  -- File tree.
  -- {
  --   'nvim-tree/nvim-tree.lua',
  --   dependencies = {
  --     'nvim-tree/nvim-web-devicons', -- optional, for file icons
  --   },
  --   tag = 'nightly' -- optional, updated every week. (see issue #1193)
  -- },

  -- Open files at the last cursor position.
  {
    'ethanholz/nvim-lastplace',
    config = function() require'nvim-lastplace'.setup() end,
  },

  -- LSP Configuration & Plugins
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',

      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
    },
  },

  -- 'ThePrimeagen/harpoon',

  -- Completion engine and sources.
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-nvim-lua',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = require'ps.pconf'.config_lualine
  },

  -- Homepage.
  {
    'goolord/alpha-nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = require'ps.pconf'.config_alpha_nvim
  },

  -- Provides command to measure startup time.
  'dstein64/vim-startuptime',

  ------------------------------------------------------------
  --                     Colorschmes                      --
  ------------------------------------------------------------
  'sainnhe/sonokai',
  'gruvbox-community/gruvbox',
  {
    'rose-pine/neovim',
    -- as = 'rose-pine',
    config = function()
      require 'rose-pine'.setup({
        -- disable_background allows for window transparency.
        -- disable_background = true
      })
    end
  },
})

-- Configure Plugins.
require'ps.pconf'.config_telescope()
-- require'ps.pconf'.config_rosepine()
require'ps.pconf'.config_lsp_plugins()

