
local M = {}

M.plugin_loaded = function(name)
  return packer_plugins[name] and packer_plugins[name].loaded
end

return M
