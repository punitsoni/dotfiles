
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local install_plugins = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  print('Installing packer at ' .. install_path)
  local packer_url = 'https://github.com/wbthomason/packer.nvim'
  vim.fn.system({'git', 'clone', '--depth', '1', packer_url, install_path})
  print('Done.')

  vim.cmd('packadd packer.nvim')
  install_plugins = true
end

install_plugins = true
print(install_plugins)

require('packer').startup(function(use)
  -- Let packer manage itself.
  use 'wbthomason/packer.nvim'

  -- Toggle code-commenting
  use 'tpope/vim-commentary'

  ---- THEMES ----
  use 'sainnhe/sonokai'
  use 'gruvbox-community/gruvbox'

  -- NOTE: Avoid these performance killer plugins.
  -- Increases startup time
  -- * vim-airline
  -- * vim -startify
end)

if install_plugins then
  -- Running sync.
  -- require('packer').sync()
end

