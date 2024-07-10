-- TODO: make sure telescope is loaded.
local telescope_builtin = require('telescope.builtin')
local alib = require('ps.actions_lib')
local actions = require'ps.actions'
local util = require'ps.utils'

local nmap = util.nmap
local vmap = util.vmap
local imap = util.imap
local tmap = util.tmap

-- Avoid entering Ex mode accidentally.
nmap ('Q','<nop>')
-- Clear search high-light.
nmap ('<space><space>',':noh<cr>:echo ""<cr>', {
  desc = 'Clear search highlight'
})
-- Edit config file.
nmap ('<space>ev',':edit $MYVIMRC<cr>')
-- Source config file.
nmap ('<space>sv',':source $MYVIMRC<cr>')
-- Page-up and Page-down.
nmap ('<c-u>','<c-u>zz')
nmap ('<c-d>','<c-d>zz')
nmap ('H','I')
nmap ('L','A')
nmap ('U','<c-r>')
-- Duplicate current line
-- nmap ('<c-o>','yyp')

--" Fold-toggle all
-- nmap ('<space>o',"&foldlevel ? 'zM' : 'zR'", {expr=true})

-- Indent and un-indent in visual mode.
vmap ('<tab>;','>gv')
vmap ('<s-tab>;','<gv')
-- Keep selection when indenting.
vmap ('>','>gv')
vmap ('<','<gv')

-- Use <Tab> and <S-Tab> to navigate through popup menu
imap ('<tab>', 'pumvisible() ? "<c-n>" : "<tab>"', {expr=true})
imap ('<s-tab>', 'pumvisible() ? "<c-p>" : "<s-tab>"', {expr=true})

---- BUFFER MANAGEMENT ----

-- Previous and next.
nmap ('<space>bp',':bp<cr>')
nmap ('<space>,',':bp<cr>')
nmap ('<space>bn',':bn<cr>')
nmap ('<space>.',':bn<cr>')
-- Select a buffer to edit.
nmap ('<space>bb', telescope_builtin.buffers)
-- Edit previous buffer (Toggle between current and alternate buffer).
nmap ('<space><tab>',':edit #<cr>')
-- Delete current buffer.
nmap ('<space>bd',':bd<cr>')
-- Delete current buffer (force)
nmap ('<space>bx',':bd!<cr>')
-- Goto alternate (last-open) buffer.
nmap ('<space>;','<C-6>')



---- WINDOW MANAGEMENT ----

nmap ('<space>w','<c-w>')
-- Maximize.
-- nmap ('<space>wm','<c-w>o')
-- Enter window-move mode.
nmap ('<space>wm',':WinShift<cr>', {
  desc = 'Move current window'
})
-- Horizontal and Vertical splits.
nmap ('<space>w-',':sp<cr>')
nmap ('<space>w<bar>',':vsp<cr>')
-- Close window.
nmap ('<space>q','<c-w>c')
-- Window navigation.
nmap ('<space>h','<c-w>h')
nmap ('<space>j','<c-w>j')
nmap ('<space>k','<c-w>k')
nmap ('<space>l','<c-w>l')

-- Find files.
nmap ('<space>ff', telescope_builtin.find_files, {
  desc = 'Find Files'
})
-- Previously open files.
nmap ('<space>fo', telescope_builtin.oldfiles)

-- Nvim config files.
-- nmap ('<space>fn', actions.nvim_config_files, {
--   desc = 'Nvim config files'
-- })
nmap ('<space>fn', function() alib.run_action('nvim-config-files') end, {
  desc = 'Nvim config files'
})

-- Help tags.
nmap ('<space>fh', telescope_builtin.help_tags, {
  desc = 'Help tags'
})
-- Livegrep (async search for filenames and text)
nmap ('<space>fl', telescope_builtin.live_grep, {
  desc = 'Live grep'
})

-- File symbols using nvim-treesitter
nmap ('<space>fs', telescope_builtin.treesitter, {
  desc = 'Find symbols'
})

nmap ('<space>/', telescope_builtin.current_buffer_fuzzy_find, {
  desc = 'Find in current buffer.'
})

nmap ('<C-b>', actions.toggle_tree, {
  desc = 'Toggle nvim-tree'
})

-- Center the line after jump.
nmap ('<C-o>', '<C-o>zz', {})
nmap ('<C-i>', '<C-i>zz', {})

nmap ('<leader><leader>h', ':Alpha<cr>', {
  desc = 'Open home page.'
})

-- Pick and run an action.
nmap ('<space>p', alib.pick_action)
nmap ('<C-p>', alib.pick_action)


-- Open/Close floating terminal.
nmap ('<space>n', ':FloatermToggle main<cr>')

-- Press Esc to enter normal mode in terminal.
tmap ('<esc>', '<C-\\><C-n>')
-- Window switching for terminal mode.
tmap ('<C-h>', '<C-\\><C-n><C-w>h')
tmap ('<C-j>', '<C-\\><C-n><C-w>j')
tmap ('<C-k>', '<C-\\><C-n><C-w>k')
tmap ('<C-l>', '<C-\\><C-n><C-w>l')


