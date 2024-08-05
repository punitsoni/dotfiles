local Path = require 'plenary.path'

local Context = {}

local kConfigDirName = '.wsp'
local kConfigFileName = 'wsp.json'
local instance = nil

-- Local private constructor.
local function NewContext()
  local result = Path.new(vim.uv.cwd()):find_upwards(kConfigDirName)

  local obj = { active = false }
  if result == '' then
    return obj
  end
  local wsp_configdir = result
  local config_filepath = wsp_configdir:joinpath(kConfigFileName)
  if not config_filepath:exists() then
    print('Error: ' .. kConfigFileName .. ' not found at ' .. wsp_configdir.filename)
    return obj
  end

  obj.active = true
  obj.configdir = wsp_configdir.filename
  obj.configfile = config_filepath.filename

  setmetatable(obj, { __index = Context })
  return obj
end

function Context:is_active()
  return self.active
end

function Context:config_file()
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
