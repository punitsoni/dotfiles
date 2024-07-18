-- Initialization for floaterm plugin.
local function SetupFloaterm()
  local util = require'ps.utils'
  local tmap = util.tmap
  local nmap = util.nmap
  vim.g.floaterm_width = 0.7
  vim.g.floaterm_height = 0.7
  vim.g.floaterm_title = ' Terminal [$1/$2] '
  vim.g.floaterm_titleposition = 'center'
  vim.g.floaterm_autoinsert = true

  -- Open/Close floating terminal.
  nmap ('<space>n', ':FloatermToggle main<cr>')
  -- nmap ('<C-q>', ':FloatermToggle main<cr>')
  vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = 'floaterm',
    callback = function(_)
      -- Ctrl-Q hides the focused floating terminal.
      tmap('<C-q>', '<C-\\><C-n>:FloatermHide<cr>')
    end
  })
end

return {
  {
    'voldikss/vim-floaterm',
    config = SetupFloaterm,
  },
}

