-- Configuration for the native neovim features.

-- Highlight search term as you type.
-- vim.opt.hlsearch = true
-- Incremental search, hit `<CR>` to stop.
vim.opt.incsearch = true
-- Show current command in statusbar
vim.opt.showcmd = true
-- Show line numbers.
vim.opt.number = true
-- Enable mouse
vim.opt.mouse = 'a'
-- Ignore case while searching
vim.opt.ignorecase = true
-- Do not create swap files
vim.opt.swapfile = false
-- keep buffers loaded when window closes, required by many plugins.
vim.opt.hidden = true
-- Shows the current line number at the bottom-right of the screen.
vim.opt.ruler = true
-- Disable backups.
vim.opt.backup= false
vim.opt.writebackup = false
-- Use spaces instead of tabs.
vim.opt.expandtab = true
-- Set default indentation size.
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
-- Dont show mode as airline already does.
vim.opt.showmode = false
-- Command-line height
vim.opt.cmdheight = 1
-- Default coding textwidth
vim.opt.textwidth = 80
-- Highlight the 81st column.
vim.opt.colorcolumn = {81}
-- No automatic wrapping of lines.
vim.opt.wrap = false
-- Use » to mark Tabs and ° to mark trailing whitespace
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '°' }
-- Enable line-numbers
vim.opt.number = true
-- Better window splits.
vim.opt.splitbelow = true
vim.opt.splitright = true

-- TODO: system keyboard makes things slow. Debug this.
-- Use system clipboard
-- opt.clipboard = 'unnamed'

-- Set the tab-completion for commands to be more similar to shell
vim.opt.wildmode = 'longest:full,full'
vim.opt.wildmenu = true
-- Ignore these files and dirs when searchig/globbing
vim.opt.wildignore = {
  -- '*/tmp/*', '*.so', '*.swp,*', '*.zip', '*.pdf', '*.o', '*.bin',
  -- '*/__pycache__/*', '*.so', '*.deb', '*.exe', '*.a',
}
-- Use number colum for diagnostic signs.
vim.opt.signcolumn = 'number'
-- Things should update faster. (default is 4000ms)
vim.opt.updatetime = 500
-- Make it so there are always ten lines below my cursor
-- opt.scrolloff = 10
-- Better completion experience.
vim.opt.completeopt = {'menuone','noinsert','noselect'}
-- Avoid showing status message when using completion.
-- opt.shortmess = opt.shortmess + {'c'}
-- Enable truecolor on terminals.
vim.opt.termguicolors = true
-- Set background dark or light for different versions of the theme.
vim.opt.background = 'dark'
-- Pop-up menu transperancy.
vim.opt.pumblend = 17
-- Do not fold small blocks.
vim.opt.foldminlines = 3
-- Start with all folds open
vim.opt.foldlevelstart = 99

-- Set space as the leader key.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Do not continue comments when pressing enter.
vim.api.nvim_create_autocmd({ 'FileType' }, {
  command = 'set formatoptions-=ro'
})


