
-- Function that is called when vim-fugitive plugin is loaded.
local function SetupFugitive()
  local actions_lib = require'ps.actions_lib'
  actions_lib.register_action({
    name = 'blame',
    func = function()
      vim.cmd('Git blame')
    end
  })
end

return {
  {
    'tpope/vim-fugitive',
    config = SetupFugitive,
  },
}

