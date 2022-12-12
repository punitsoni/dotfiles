-------------------------------------------------------------------------------
-- Actions
-- Basic actions.
-------------------------------------------------------------------------------
local ts_builtin = require 'telescope.builtin'
local alib = require 'ps.actions_lib'

alib.register_action({
  name = 'Find files',
  func = ts_builtin.find_files,
})

alib.register_action({
  name = 'Colorschemes',
  func = ts_builtin.colorscheme,
})

