-- colorscheme should be available when starting Neovim. Hence we do not lazy
-- load them and set high priority.
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      -- Fix annoying high-contrast virtual text shown for warnings.
      highlight_overrides = {
        mocha = function(colors)
          return {
            DiagnosticVirtualTextWarn = { fg = colors.surface1, bg=colors.base },
          }
        end
      }
    }
  },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- Set colorscheme when loaded.
      -- vim.cmd([[colorscheme tokyonight-night]])
    end,
  },

  {'sainnhe/sonokai'},

  { 'rose-pine/neovim' },

  { "olimorris/onedarkpro.nvim" },
}

