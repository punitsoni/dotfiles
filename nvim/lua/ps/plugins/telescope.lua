local function SetupTelescope()
  local actions = require 'telescope.actions'
  require('telescope').setup {
    defaults = {
      -- Command that is used for live_grep.
      vimgrep_arguments = {
        "rg",
        "--follow",      -- Follow symbolic links
        "--hidden",      -- Search for hidden files
        "--no-heading",  -- Don't group matches by each file
        "--with-filename", -- Print the file path with the matched lines
        "--line-number", -- Show line numbers
        "--column",      -- Show column numbers
        "--smart-case",  -- Smart case search
      },
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
        fuzzy = true,                   -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true,    -- override the file sorter
        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      }
    }
  }
  require('telescope').load_extension('fzf')
end

return {
  {
    'nvim-telescope/telescope.nvim',
    config = SetupTelescope,
    dependencies = { 'nvim-lua/plenary.nvim',
      -- Native fuzzy finder for telescope. Requires building.
      -- TODO: make sure gcc/clang and make is available.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
      },
    },
  },
}
