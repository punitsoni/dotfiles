
-- Ensures that the package manager packer is installed. Returns true if this
-- was a first-time setup and packer was newly installed.
local ensure_packer = function()

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

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  -- Let packer manage itself.
  use 'wbthomason/packer.nvim'

  -- Toggle code-commenting
  use 'tpope/vim-commentary'

  -- Telescope fuzzy-finder.
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    requires = {'nvim-lua/plenary.nvim'}
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })()
    end
  }

  ---- THEMES ----
  use 'sainnhe/sonokai'
  use 'gruvbox-community/gruvbox'

  -- NOTE: Avoid these performance killer plugins.
  -- Increases startup time
  -- * vim-airline
  -- * vim-startify

  if packer_bootstrap then
    require('packer').sync()
  end
end)

require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'lua', 'c', 'cpp', 'python', 'bash'
  },
  sync_install = false,
  highlight = {
    enable = true,
  },
  indent = {
    enable = true
  }
}

telescope_actions = require('telescope.actions')

require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ['<esc>'] = telescope_actions.close
      },
    },
    layout_strategy = 'center',
    preview = {
      hide_on_startup = true,
      filesize_limit = 5
    }
  },
}

