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
    dependencie = { 'nvim-lua/plenary.nvim' },
    config = require 'ps.config.telescope'
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
    config = require 'ps.config.treesitter'
  },

  -- File tree.
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    config = require 'ps.config.nvim-tree',
  },

  -- Open files at the last cursor position.
  {
    'ethanholz/nvim-lastplace',
    config = function() require 'nvim-lastplace'.setup() end,
  },

  -- Better ui for input and select.
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy'
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

  -- Harpoon: quickly switch between imp files in project.
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = require 'ps.config.harpoon',
  },

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
    config = require 'ps.config.lualine'
  },

  -- Homepage.
  {
    'goolord/alpha-nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require 'alpha'.setup(require 'alpha.themes.startify'.config)
    end,
  },

  -- Provides command to measure startup time.
  -- 'dstein64/vim-startuptime',

  -- Tmux navigation.
  {
    'alexghergh/nvim-tmux-navigation',
    config = require 'ps.config.nvim-tmux-navigation',
  },

  {
    'lewis6991/gitsigns.nvim',
    config = require 'ps.config.gitsigns',
  },

  {
    'tpope/vim-fugitive',
    config = require 'ps.config.fugitive',
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function() require 'which-key'.setup() end,
  },

  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    -- TODO Move keymaps to the general keymaps.lua
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },

  -- Awesome plugin to move windows / splits around.
  {
    'sindrets/winshift.nvim'
  },

  {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = require 'ps.config.bufferline',
  },

  -- Show symbols sidebar.
  {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = {
      { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
    config = function()
      require 'outline'.setup {
        outline_window = {
          hide_cursor = true,
          focus_on_open = false,

        },
        symbols = {
          default = { 'String', exclude = true },
          python = { 'Function', 'Class' },
        },
      }
    end
  },

  -- Floating terminal.
  {
    'voldikss/vim-floaterm',
    config = require'ps.config.floaterm',
  },

  ------------------------------------------------------------
  --                      Colorschmes                       --
  ------------------------------------------------------------

  'sainnhe/sonokai',
  'gruvbox-community/gruvbox',
  {
    'rose-pine/neovim',
    config = function()
      require 'rose-pine'.setup({
        -- disable_background allows for window transparency.
        -- disable_background = true
      })
    end
  },
  {
    "olimorris/onedarkpro.nvim",
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    -- priority = 1000
    config = require 'ps.config.catppuccin',
  },
})

-- Configure Plugins.
require 'ps.config.lsp'
