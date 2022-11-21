
local M = {}

-- Ensures that the package manager packer is installed. Returns true if this
-- was a first-time setup and packer was newly installed.
M.ensure_packer = function()
  local install_path =
    vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    print('Installing packer at ' .. install_path)
    local packer_url = 'https://github.com/wbthomason/packer.nvim'
    vim.fn.system({'git', 'clone', '--depth', '1', packer_url, install_path})
    print('Done.')
    vim.cmd('packadd packer.nvim')
    return true
  end
  return false
end

-- Checks if plugin is loaded.
M.plugin_loaded = function(name)
  return packer_plugins[name] and packer_plugins[name].loaded
end

return M
