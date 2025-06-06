return {
  -- {
  --   "stevearc/conform.nvim",
  --   -- event = 'BufWritePre', -- uncomment for format on save
  --   opts = require "configs.conform",
  -- },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  -- Homepage.
  {
    "goolord/alpha-nvim",
    -- dependencies = { "kyazdani42/nvim-web-devicons" },
    lazy = false,
    config = function()
      require("alpha").setup(require("alpha.themes.startify").config)
    end,
  },

  --     {
  --       'numToStr/Comment.nvim',
  --       opts = {}
  --     },
  --
  --     -- Quotes.
  --     'tpope/vim-surround',
  --
  --     -- Open files at the last cursor position.
  --     {
  --       'ethanholz/nvim-lastplace',
  --       event = "VeryLazy",
  --       opts = {},
  --     },
  --
  --     -- Better ui for input and select.
  --     {
  --       'stevearc/dressing.nvim',
  --       event = 'VeryLazy'
  --     },
  --
  --     -- Harpoon: quickly switch between imp files in project.
  --     {
  --       "ThePrimeagen/harpoon",
  --       event = "VeryLazy",
  --       branch = "harpoon2",
  --       dependencies = { "nvim-lua/plenary.nvim" },
  --     },
  --
  --
  --
  --     -- Awesome plugin to move windows / splits around.
  --     {
  --       'sindrets/winshift.nvim',
  --       event = "VeryLazy",
  --       opts = {},
  --     },
  --
  --
  --     -- Indenting guides.
  --     {
  --       "lukas-reineke/indent-blankline.nvim",
  --       main = "ibl",
  --       opts = {}
  --     },
  --
  --     {
  --       'ii14/neorepl.nvim',
  --       -- Lazy-load this plugin on this command.
  --       cmd = 'Repl',
  --     },
  --
  --     -- Highlight symbol under cursor.
  --     {
  --       'RRethy/vim-illuminate',
  --       event = "VeryLazy",
  --     },
  --
  --     {
  --       'dgagn/diagflow.nvim',
  --       opts = {
  --         scope = 'line',
  --         show_sign = true,
  --         -- placement = 'inline',
  --         -- inline_padding_left = 3,
  --         -- show_borders does not work properly with inline placement.
  --         -- show_borders = false,
  --       }
  --     },
  --
  --     {
  --       'dnlhc/glance.nvim',
  --       opts = {}
  --     },
  --
  --     {
  --       "SmiteshP/nvim-navbuddy",
  --       dependencies = {
  --         "SmiteshP/nvim-navic",
  --         "MunifTanjim/nui.nvim"
  --       },
  --       opts = { lsp = { auto_attach = true } }
  --     },
  --
  --     -- Debugger interface.
  --     {
  --       "rcarriga/nvim-dap-ui",
  --       event = 'VeryLazy',
  --       dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }
  --     },
  --
  --     {
  --       'nanozuki/tabby.nvim',
  --       event = 'VeryLazy', -- if you want lazy load, see below
  --       dependencies = 'nvim-tree/nvim-web-devicons',
  --       config = function()
  --       end,
  --     }
}
