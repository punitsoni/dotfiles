------------------------------------------------------------
-- Initializes packer and lists the plugins to be loaded.
------------------------------------------------------------

local utils = require 'ps.utils'

local is_first_time = utils.ensure_packer()

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

  -- Native fuzzy finder for telescope. Requires building.
  -- TODO: make sure gcc/clang and make is available.
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make' 
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })()
    end
  }

  use 'ThePrimeagen/harpoon'

  -- Configurations for neovim lsp
  use 'neovim/nvim-lspconfig'

  -- Completion engine and sources.
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'

  -- Status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- Colorscheme sonokai
  use 'sainnhe/sonokai'
  -- Colorscheme gruvbox
  use 'gruvbox-community/gruvbox'

  if is_first_time then
    require('packer').sync()
  end
end)

if is_first_time then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end






