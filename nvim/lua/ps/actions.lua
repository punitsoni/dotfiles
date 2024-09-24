-------------------------------------------------------------------------------
-- Actions
-- Defines top-level UI fnctions which can be mapped to a keystroke or a menu
-- item.
-------------------------------------------------------------------------------
local ts_builtin = require 'telescope.builtin'
local alib = require 'ps.actions_lib'
local util = require 'ps.utils'
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
  require 'nvim-tree.api'.tree.toggle(
    {
      focus = true,
      find_file = true,
      -- update_root = true,
    })
end

-- Deletes current buffer while keeping the window / split open.
M.delete_curbuf = function()
  vim.cmd('bp|sp|bn|bd')
end

M.toggle_edgy_left = function()
  require 'edgy'.toggle('left')
end

-- Sync tree to current file. Opening if not opened.
alib.register_action({
  name = 'sync-tree',
  func = function()
    require("neo-tree.command").execute({ action = "focus", reveal = true })
    -- require 'nvim-tree.api'.tree.open(
    --   {
    --     focus = false,
    --     find_file = true,
    --     update_root = true,
    --   })
  end,
})

alib.register_action({
  name = 'zoom',
  func = function()
    require 'mini.misc'.zoom(nil, {
      width = 0.9,
      height = 0.9,
    })
  end
})

alib.register_action({
  name = 'switch-source-header',
  func = function()
    vim.cmd('ClangdSwitchSourceHeader')
  end
})

alib.register_action({
  name = 'quit',
  func = function()
    vim.cmd('confirm qall')
  end
})

alib.register_action({
  name = 'find-files',
  func = function()
    if wsp.is_active() then
      wsp.find_files()
    else
      ts_builtin.find_files()
    end
  end
})

M.live_grep = function()
  if wsp.is_active() then
    wsp.live_grep()
  else
    ts_builtin.live_grep()
  end
end

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
  func = wsp.find_files
})

alib.register_action({
  name = 'wsp-grep',
  func = wsp.live_grep
})

alib.register_action({
  name = 'wsp-edit-config',
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

alib.register_action({
  name = 'copy-current-path',
  func = function()
    -- Write current buffer path into vim register + which represents system
    -- clipboard.
    path = vim.fn.expand('%')
    util.copy_to_clipboard(path)
    print("Copied: " .. path)
  end,
})

alib.register_action({
  name = 'tmux-sessions',
  func = function()
    -- TODO: BUG Floaterm is not starting in insert mode when started from
    -- actions menu.
    vim.cmd(
      'FloatermNew --width=64 --height=16 --title=\\ Tmux-Sessions\\ '
      .. ' --disposable --autoclose=2'
      .. ' bash $DOTFILES/scripts/tmux_sessionizer.sh'
    )
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

alib.register_action({
  name = 'sessions',
  func = function ()
    vim.cmd('SessionManager load_session')
  end,
})

return M
