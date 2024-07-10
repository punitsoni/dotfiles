-- Initialization for floaterm plugin.
local function SetupFloaterm()
  local util = require'ps.utils'
  vim.g.floaterm_width = 0.7
  vim.g.floaterm_height = 0.7
  vim.g.floaterm_titleposition = 'center'

  vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = 'floaterm',
    callback = function(_)
      -- Esc to hide floating terminal.
      util.tmap('<Esc>', '<C-\\><C-n>:FloatermHide<cr>')
    end
  })
end

return {
  {
    'voldikss/vim-floaterm',
    config = SetupFloaterm,
  },
}

