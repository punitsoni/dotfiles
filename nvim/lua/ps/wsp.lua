local builtin = require'telescope.builtin'
local pickers = require'telescope.pickers'
local finders = require'telescope.finders'
local conf = require'telescope.config'.values

local Path = require 'plenary.path'

local CONFIG_DIRNAME = '.wsp'
local CONFIG_FILENAME = 'wsp.json'

-- Removes newline char from a string.
local function strip(s)
  return string.gsub(s, '\n', '')
end

-- Converts a path that is relative to refdir to absolute path.
local function abspath(refdir, relpath)
  return strip(vim.fn.system(
           -- {'sh', '-c', 'cd ' .. refdir .. ' && realpath ' .. relpath }))
           'cd '.. refdir .. ' && realpath ' .. relpath))
end

-- Find wsp config in or up from the current directory.
local function get_wsp_config()
  cwd = vim.fn.getcwd()
  configdir = vim.fn.finddir(CONFIG_DIRNAME, cwd..';')
  if configdir == '' then
    return
  end

  configdir = abspath(cwd, configdir)
  config_file = vim.fn.findfile(configdir..'/'..CONFIG_FILENAME, configdir)
  if config_file == '' then
    print('error: wsp.json not found at '..configdir)
    return
  end
  -- print('configdir='..configdir)

  config_json = vim.fn.join(vim.fn.readfile(config_file), '\n')
  config = vim.fn.json_decode(config_json)
  config.rootdir = strip(vim.fn.system('realpath '..configdir..'/'..'..'))

  -- vim.pretty_print(config)

  return config
end

wsp_config = get_wsp_config()

local M = {}

function M.new_workspace()
  cwd = vim.fn.getcwd()
end

-- Opens a ui to find and select a file in the workspace.
function M.select_file()
  builtin.find_files({
    search_dirs = vim.tbl_map(
      function (d)
        if Path:new(d):is_absolute() then
          return d
        end
        -- Use Path lib to join these paths.
        return wsp_config.rootdir ..'/'.. d
      end,
      wsp_config.dirs
    )
  })
end

function M.test()
  f = M.select_file()
  -- print('selected='..f)
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
