-- Configuration for the native neovim features.

-- Shorthand for executing vim commands.
local runcmd = vim.cmd
-- Shorthand for calling vim functions.
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
-- Shorthand for vim options.
local opt = vim.opt



------------- Options ---------------

-- Highlight search term as you type.
opt.hlsearch = true
-- Incremental search, hit `<CR>` to stop.
opt.incsearch = true
-- Show current command in statusbar
opt.showcmd = true
-- Show line numbers.
opt.number = true
-- Enable mouse
opt.mouse = 'a'
-- Ignore case while searching
opt.ignorecase = true
-- Do not create swap files
opt.swapfile = false
-- keep buffers loaded when window closes, required by many plugins.
opt.hidden = true
-- Shows the current line number at the bottom-right of the screen.
opt.ruler = true
-- Disable backups.
opt.backup= false
opt.writebackup = false
-- Use spaces instead of tabs.
opt.expandtab = true
-- Set default indentation size.
opt.tabstop = 2
opt.shiftwidth = 2
-- Dont show mode as airline already does.
opt.showmode = false
-- Command-line height
opt.cmdheight = 1
-- Default coding textwidth
opt.textwidth = 80
-- Highlight the 81st column.
opt.colorcolumn = {81}
-- No automatic wrapping of lines.
opt.wrap = false
-- Use » to mark Tabs and ° to mark trailing whitespace
opt.list = true
opt.listchars = { tab = '» ', trail = '°' }
-- Enable line-numbers
opt.number = true
-- Better window splits.
opt.splitbelow = true
opt.splitright = true
-- Use system clipboard
opt.clipboard = 'unnamed'
-- Set the tab-completion for commands to be more similar to shell
opt.wildmode = 'longest:full,full'
opt.wildmenu = true
-- Ignore these files and dirs when searchig/globbing
opt.wildignore = {
  -- '*/tmp/*', '*.so', '*.swp,*', '*.zip', '*.pdf', '*.o', '*.bin',
  -- '*/__pycache__/*', '*.so', '*.deb', '*.exe', '*.a',
}
-- Use number colum for diagnostic signs.
opt.signcolumn = 'number'
-- Things should update faster.
opt.updatetime = 1000
-- Make it so there are always ten lines below my cursor
-- opt.scrolloff = 10
-- Better completion experience.
opt.completeopt = {'menuone','noinsert','noselect'}
-- Avoid showing status message when using completion.
-- opt.shortmess = opt.shortmess + {'c'}
-- Enable truecolor on terminals.
opt.termguicolors = true
-- Set background dark or light for different versions of the theme.
opt.background = 'dark'
-- Pop-up menu transperancy.
opt.pumblend = 17

-- TODO: Currently following does not work due to a bug.
-- runcmd ([[
--   augroup AllFileTypes
--   autocmd!
--   autocmd FileType * :setlocal formatoptions-=o
--   augroup END
-- ]])


