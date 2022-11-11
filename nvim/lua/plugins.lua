local runcmd = vim.cmd  -- to execute Vim commands e.g. runcmd('pwd')

local install_plugins = false

-- if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
--   print('Installing packer...')
--   local packer_url = 'https://github.com/wbthomason/packer.nvim'
--   vim.fn.system({'git', 'clone', '--depth', '1', packer_url, install_path})
--   print('Done.')
-- 
--   vim.cmd('packadd packer.nvim')
--   install_plugins = true
-- end

-- Installs paq if it is not installed already.
local function paq_init()
  local stdpath_data = vim.fn.stdpath('data')
  local pac_install_dir = stdpath_data .. '/site/pack/paqs/start/paq-nvim'
  if 0 == vim.fn.isdirectory(pac_install_dir) then
    print('installing pac...')
    runcmd('silent !git clone --depth=1 https://github.com/savq/paq-nvim.git '
      .. pac_install_dir)
    print('DONE')
  end
  -- Load paq plugin manager.
  runcmd 'packadd paq-nvim'
  return require 'paq-nvim'
end

local paq = paq_init()

paq {
  -- Let paq manage itself.
  { 'savq/paq-nvim' };

  -- BASICS
  -- Plugin for built-in treesitter configuration.
  { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
  -- Config for builtin LSP client.
  { 'neovim/nvim-lspconfig' },
  -- Toggle code-commenting
  {'tpope/vim-commentary'},
  -- Better looking status line.
  -- { 'vim-airline/vim-airline' },
  -- Nice startup page.
  -- { 'mhinz/vim-startify' },

  -- THEMES
  { 'sainnhe/sonokai' },

  -- telescope with dependencies
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-lua/popup.nvim' },
  { 'nvim-telescope/telescope.nvim' },

  -- EXPERIMENTAL
  { 'dstein64/vim-startuptime' },

  -- NOTE: Avoid these performance killer plugins.
  -- Increases startup time
  -- * vim-airline
  -- * vim -startify
}

paq.install()

require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    'lua', 'c', 'cpp', 'python', 'bash', 'javascript', 'html', 'json'
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true
  }
}

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

require'telescope'.setup{
  defaults = {
    prompt_prefix = '>> ',
    winblend = 15,
  }
}

