local function ConfigNvimSessionManager()
  local Path = require('plenary.path')
  local config = require('session_manager.config')

  require('session_manager').setup({
    -- autoload_mode = config.AutoloadMode.CurrentDir,
    autoload_mode = config.AutoloadMode.Disabled,
    autosave_last_session = true,
    autosave_ignore_not_normal = true,
    autosave_ignore_dirs = {},
    autosave_ignore_filetypes = {
      'gitcommit',
      'gitrebase',
    },
    -- All buffers of these bufer types will be closed before the session is saved.
    autosave_ignore_buftypes = {},
    -- Always autosaves session. If true, only autosaves after a session is active.
    autosave_only_in_session = false,
    -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
    max_path_length = 80,
  })
end


return {
  {
    'Shatur/neovim-session-manager',
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
    },
    config = ConfigNvimSessionManager
  }
}
