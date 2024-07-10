
local util = require'ps.utils'

-- Initialization for floaterm plugin.
M = function()
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

return M
