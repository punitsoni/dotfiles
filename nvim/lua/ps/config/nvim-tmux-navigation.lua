local nmap = require'ps.utils'.nmap

M = function()
  local nav = require('nvim-tmux-navigation')
  nav.setup {
    disable_when_zoomed = true -- defaults to false
  }

  nmap ('<C-h>', nav.NvimTmuxNavigateLeft, {
    desc = 'NvimTmuxNavigateLeft'
  })
  nmap ('<C-j>', nav.NvimTmuxNavigateDown, {
    desc = 'NvimTmuxNavigateDown'
  })
  nmap ('<C-k>', nav.NvimTmuxNavigateUp, {
    desc = 'NvimTmuxNavigateUp'
  })
  nmap ('<C-l>', nav.NvimTmuxNavigateRight, {
    desc = 'NvimTmuxNavigateRight'
  })
  nmap ('<C-\\>', nav.NvimTmuxNavigateLastActive, {
    desc = 'NvimTmuxNavigateLastActive'
  })
  nmap ('<C-Space>', nav.NvimTmuxNavigateNext, {
    desc = 'NvimTmuxNavigateNext'
  })

end

return M
