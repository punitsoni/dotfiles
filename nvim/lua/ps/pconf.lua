-- A module that defines configurations for plugins --

local M = {}

-- Configure plugin telescope.nvim.
function M.config_telescope()
  local actions = require 'telescope.actions'
  require('telescope').setup {
    defaults = {
      mappings = {
        i = {
          ["<esc>"] = actions.close,
        },
      },
      -- Disable the file-preview.
      preview = false,
      layout_config = {
        horizontal = {
          height = 0.7,
          width = 0.7,
        },
      },
      -- winblend = 15,
    },
    extensions = {
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      }
    }
  }
  require('telescope').load_extension('fzf')
end

-- Configure plugin lualine.
function M.config_lualine()
  require'lualine'.setup {
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'vim.g.wsp_mode', 'branch', 'diff', 'diagnostics'},
      lualine_c = {'filename'},
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
  }
end

-- Configure plugin alpha.nvim.
function M.config_alpha_nvim()
  require'alpha'.setup(require'alpha.themes.startify'.config)
end

-- Configure theme rose-pine.
function M.config_rosepine()
  require'rose-pine'.setup {
    -- disable_background allows for window transparency.
    -- disable_background = true
  }
end

-- Setup all lsp related plugins.
function M.config_lsp_plugins()
  require'ps.config_lsp'.setup_all()
end

return M

