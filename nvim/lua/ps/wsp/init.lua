local Context = require'ps.wsp.context'

-- wsp module.
local wsp = {}

local function ctx()
  return Context.Instance()
end

local function check_active()
  if not ctx().is_active() then
    error('Not in active workspace')
  end
end

function wsp.init()
  Context.Instance()
end

-- Returns path to the config file.
-- Error if wsp not active.
function wsp.config_file()
  check_active()
  return ctx().configfile
end


