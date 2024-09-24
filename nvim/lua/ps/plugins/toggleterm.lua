local function get_size(term)
  if term.direction == "horizontal" then
    return 20
  end
  if term.direction == "vertical" then
    if vim.o.columns < 240 then
      return vim.o.columns * 0.5
    end
    return 130
  end
end


function ConfigToggleTerm()
  require 'toggleterm'.setup {
    size = get_size,
    open_mapping = '<C-n>',
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    -- Darken terminal background (percent)
    shading_factor = -20,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    persist_mode = true,
    direction = "vertical",
    float_opts = {
      border = "curved",
      winblend = 0,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
  }

  local Terminal = require('toggleterm.terminal').Terminal

  vim.api.nvim_create_user_command(
    "TermTab",
    function(opts)
      local term = Terminal:new({
        direction = "tab",
        -- function to run on opening the terminal
        on_open = function(term)
          print('term open')
          -- TODO: set tab name.
        end,

      })
    end,
    { nargs = 0 }
  )
end

return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = ConfigToggleTerm,
  }
}
