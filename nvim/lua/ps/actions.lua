-------------------------------------------------------------------------------
-- Actions
-- Basic actions.
-------------------------------------------------------------------------------
local ts_builtin = require 'telescope.builtin'
local alib = require 'ps.actions_lib'
local utils = require 'ps.utils'
local wsp = require 'ps.wsp'

alib.register_action({
  name = 'find-files',
  func = ts_builtin.find_files,
})

alib.register_action({
  name = 'help-topics',
  func = ts_builtin.help_tags,
})

alib.register_action({
  name = 'colorschemes',
  func = ts_builtin.colorscheme,
})

-- Select from nvim config files.
alib.register_action({
  name = 'nvim-config-files',
  func = function()
    ts_builtin.find_files({
      cwd = vim.fn.stdpath('config')
    })
  end,
})

alib.register_action({
  name = 'wsp-files',
  func = wsp.select_file
})
