local builtin = require'telescope.builtin'
-- local pickers = require'telescope.pickers'
-- local finders = require'telescope.finders'
-- local conf = require'telescope.config'.values
local util = require'ps.utils'
local Path = require 'plenary.path'

local CONFIG_DIRNAME = '.wsp'
local CONFIG_FILENAME = 'wsp.json'

-- Find wsp config in or up from the current directory.
local function get_wsp_config()
  local cwd = vim.fn.getcwd()
  local configdir = vim.fn.finddir(CONFIG_DIRNAME, cwd..';')
  if configdir == '' then
    return
  end

  configdir = util.abspath(cwd, configdir)
  local config_file = vim.fn.findfile(
                        configdir..'/'..CONFIG_FILENAME, configdir)
  if config_file == '' then
    print('error: wsp.json not found at '..configdir)
    return
  end
  -- print('configdir='..configdir)

  local config_json = vim.fn.join(vim.fn.readfile(config_file), '\n')
  local config = vim.fn.json_decode(config_json)
  config.rootdir = util.strip(vim.fn.system('realpath '..configdir..'/'..'..'))
  return config
end

local wsp_config = get_wsp_config()
if wsp_config then
  vim.g.wsp_mode = 'wsp'
end

local M = {}

function M.new_workspace()
  local cwd = vim.fn.getcwd()
end

function M.is_wsp_active()
  return wsp_config ~= nil
end

-- Opens a ui to find and select a file in the workspace.
function M.select_file()
  if not M.is_wsp_active() then
    print('wsp not active')
    return
  end
  builtin.find_files({
    search_dirs = vim.tbl_map(
      function (d)
        if Path:new(d):is_absolute() then
          return d
        end
        -- TODO: Use Path lib to join these paths.
        return wsp_config.rootdir ..'/'.. d
      end,
      wsp_config.dirs
    )
  })
end

function M.test()
  local f = M.select_file()
  print('selected='..f)
end

return M

--[[

- A workspace is a directory with .wsp/ subdir
- we should go in workspace mode when cwd is a subdir of a workspace
- Can we run an autocmd when cwd is changed?
- Show that we are in a workspace in lualine.


Run test

nvim --headless -c "lua require'ps.wsp'.test()" -c q

--]]
