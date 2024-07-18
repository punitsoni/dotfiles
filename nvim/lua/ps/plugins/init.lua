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

    -- Indenting guides.
    {
      "lukas-reineke/indent-blankline.nvim",
      main = "ibl",
      opts = {}
    },

    -- TODO This might not be needed anymore as we have noice.
    {
      'VonHeikemen/fine-cmdline.nvim',
      enabled = false,
      dependencies = {
        'MunifTanjim/nui.nvim',
      },
      config = function()
        require'fine-cmdline'.setup {
          popup = {
            position = {
              row = '80%',
              col = '50%',
            },
            relative = 'editor',
            size = {
              width = '50%',
            },
            border = {
              style = 'rounded',
              text = {
                top = ' Command ',
              },
            },
            win_options = {
              winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
            },
          },
        }
        require'ps.utils'.nmap(':', '<cmd>FineCmdline<cr>')
        require'ps.utils'.nmap('<C-;>', '<cmd>')
      end
    },

    -- Shows a context line (e.g. function name) when scrolling.
    {
      'nvim-treesitter/nvim-treesitter-context',
      opts = {
        max_lines = 1,
        mode = 'topline',
        trim_scope = 'inner',
      },
    },

    -- Automatically save files.
    {
      "okuuva/auto-save.nvim",
      enabled = false,
      opts = { },
    },

    {
      'ii14/neorepl.nvim',
      -- Lazy-load this plugin on this command.
      cmd = 'Repl',
    },

    -- Highlight symbol under cursor.
    {
      'RRethy/vim-illuminate'
    },
  },
}

