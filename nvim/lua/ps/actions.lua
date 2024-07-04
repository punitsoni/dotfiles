-------------------------------------------------------------------------------
-- Actions
-- Defines top-level UI fnctions which can be mapped to a keystroke or a menu
-- item.
-------------------------------------------------------------------------------
local ts_builtin = require 'telescope.builtin'
local alib = require 'ps.actions_lib'
local utils = require 'ps.utils'
local wsp = require 'ps.wsp'

local this = {}

-- Select from nvim config files.
this.nvim_config_files = function()
  ts_builtin.find_files({
    cwd = vim.fn.stdpath('config')
  })
end

alib.register_action({
  name = 'nvim-config-files',
  func = this.nvim_config_files
})

-- Toggle tree sidebar.
this.toggle_tree = function()
  require'nvim-tree.api'.tree.toggle(
    {
      focus = false,
      find_file = true,
      update_root = true,
    })
end

-- Sync tree to current file. Opening if not opened.
this.sync_tree = function()
  require'nvim-tree.api'.tree.open(
    {
      focus = false,
      find_file = true,
      update_root = true,
    })
end
alib.register_action({
  name = 'sync-tree',
  func = this.sync_tree,
})

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

alib.register_action({
  name = 'wsp-files',
  func = wsp.select_file
})

alib.register_action({
  name = 'wsp-config',
  func = wsp.edit_config,
})

return this
