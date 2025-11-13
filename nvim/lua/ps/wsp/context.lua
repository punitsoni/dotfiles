local Path = require 'plenary.path'

local Context = {}

local kConfigDirName = '.wsp'
local kConfigFileName = 'wsp.json'
local instance = nil


local function GetConfig(configdir)
  vim.opt.rtp:prepend(configdir)
  -- Try to load local settings if exists. If not, we do nothing.
  local status_ok, wsp_local = pcall(require, 'wsp_local')
  if not status_ok then
    return nil
  end
  return wsp_local.config
end


-- Local private constructor.
local function NewContext()
  local result = Path.new(vim.uv.cwd()):find_upwards(kConfigDirName)

  local obj = { active = false }
  if result == '' then
    return obj
  end

  vim.print("result = " .. result)
  local wsp_configdir = result
  local wsp_rootdir = result:parent()

  -- local config_filepath = wsp_configdir:joinpath(kConfigFileName)
  -- if not config_filepath:exists() then
  --   print('Error: ' .. kConfigFileName .. ' not found at ' .. wsp_configdir.filename)
  --   return obj
  -- end

  local config = GetConfig(wsp_configdir.filename)
  if not config then
    return obj
  end

  obj.config = config
  obj.configdir = wsp_configdir.filename
  -- obj.configfile = config_filepath.filename
  obj.active = true
  obj.rootdir = wsp_rootdir.filename

  setmetatable(obj, { __index = Context })
  return obj
end

function Context:check_active()
  if not self.active then
    error('Not in workspace.')
  end
end

function Context:is_active()
  return self.active
end

function Context:config_file()
  self:check_active()
  return self.configfile
end

function Context.Instance()
  if instance then
    return instance
  end
  return NewContext()
end

setmetatable(Context, {
  __call = function()
    error('Context is a singleton. Use Instance() method to get the instance')
  end
})

return Context
