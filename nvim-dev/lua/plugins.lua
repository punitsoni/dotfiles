local runcmd = vim.cmd  -- to execute Vim commands e.g. runcmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()


-- Installs paq if it is not installed already.
local function paq_init()
  local stdpath_data = fn.stdpath('data')
  local pac_install_dir = stdpath_data .. '/site/pack/paqs/start/paq-nvim'
  if 0 == fn.isdirectory(pac_install_dir) then
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
  { 'vim-airline/vim-airline' },
  -- THEMES
  { 'sainnhe/sonokai' },
  -- EXPERIMENTAL
  -- telescope with dependencies
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-lua/popup.nvim' },
  { 'nvim-telescope/telescope.nvim' },
}

require 'nvim-treesitter.configs'.setup {
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

require('telescope').setup{
  defaults = {
    prompt_prefix = '>> ',
    winblend = 15,
  }
}

runcmd 'silent! colorscheme sonokai'
