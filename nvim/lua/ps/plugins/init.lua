return {
  {
    -- Toggle code-commenting
    'tpope/vim-commentary',
    -- Quotes.
    'tpope/vim-surround',

    -- Open files at the last cursor position.
    {
      'ethanholz/nvim-lastplace',
      opts = {},
    },

    -- Better ui for input and select.
    {
      'stevearc/dressing.nvim',
      event = 'VeryLazy'
    },

    -- Harpoon: quickly switch between imp files in project.
    {
      "ThePrimeagen/harpoon",
      branch = "harpoon2",
      dependencies = { "nvim-lua/plenary.nvim" },
    },

    -- Homepage.
    {
      'goolord/alpha-nvim',
      dependencies = { 'kyazdani42/nvim-web-devicons' },
      config = function()
        require 'alpha'.setup(require 'alpha.themes.startify'.config)
      end,
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
      cmd = "Trouble",
      opts = {},
    },

    -- Awesome plugin to move windows / splits around.
    {
      'sindrets/winshift.nvim',
      opts = {},
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

    {
      'VonHeikemen/fine-cmdline.nvim',
      dependencies = {
        'MunifTanjim/nui.nvim',
      },
      config = function()
        require'fine-cmdline'.setup {
          popup = {
            position = {
              row = '40%',
              col = '50%',
            },
            size = {
              width = '50%',
            },
            border = {
              style = 'rounded',
            },
            win_options = {
              winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
            },
          },
        }
        require'ps.utils'.nmap(':', '<cmd>FineCmdline<cr>')
      end
    },

  },
}
