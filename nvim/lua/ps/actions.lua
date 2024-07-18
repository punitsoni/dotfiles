-------------------------------------------------------------------------------
-- Actions
-- Defines top-level UI fnctions which can be mapped to a keystroke or a menu
-- item.
-------------------------------------------------------------------------------
local ts_builtin = require 'telescope.builtin'
local alib = require 'ps.actions_lib'
local utils = require 'ps.utils'
local wsp = require 'ps.wsp'

local M = {}

-- Select from nvim config files.
alib.register_action({
  name = 'nvim-config-files',
  func = function()
    ts_builtin.find_files({
      cwd = vim.fn.stdpath('config')
    })
  end,
})

-- Toggle tree sidebar.
M.toggle_tree = function()
  -- require 'nvim-tree.api'.tree.toggle(
  --   {
  --     focus = false,
  --     find_file = true,
  --     update_root = true,
  --   })
  -- require'neotree'
end

-- Deletes current buffer while keeping the window / split open.
M.delete_curbuf = function()
  vim.cmd('bp|sp|bn|bd')
end

M.toggle_edgy_left = function()
  require'edgy'.toggle('left')
end

-- Sync tree to current file. Opening if not opened.
alib.register_action({
  name = 'sync-tree',
  func = function()
    require 'nvim-tree.api'.tree.open(
      {
        focus = false,
        find_file = true,
        update_root = true,
      })
  end,
})

alib.register_action({
  name = 'quit',
  func = function()
    vim.cmd('confirm qall')
  end
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

alib.register_action({
  name = 'lazygit',
  func = function()
    if not vim.fn.executable('lazygit') then
      print('lazygit is not installed. Please install it to use this function')
      return
    end
    vim.cmd [[FloatermNew --width=0.8 --height=0.9 --title=\ LazyGit\  lazygit]]
  end,
})

M.symbols_toggle = function()
  -- vim.cmd 'Trouble symbols toggle pinned=true results.win.relative=win results.win.position=right'
  require 'trouble'.toggle {
  }
end

alib.register_action({
  name = 'symbols-toggle',
  func = M.symbols_toggle,
})

return M

