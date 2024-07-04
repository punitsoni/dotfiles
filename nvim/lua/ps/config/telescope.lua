
M = function()
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

return M
