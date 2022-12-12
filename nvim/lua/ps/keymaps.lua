-- TODO: make sure telescope is loaded.
telescope_builtin = require('telescope.builtin')
alib = require('ps.actions_lib')

-- Helper function for keymapping.
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts = vim.tbl_extend('force', opts, {noremap = true})
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Avoid entering Ex mode accidentally.
map ('n','Q','<nop>')
-- Clear search high-light.
map ('n','<space><space>',':noh<cr>:echo ""<cr>')
-- Edit config file.
map ('n','<space>ev',':edit $MYVIMRC<cr>')
-- Source config file.
map ('n','<space>sv',':source $MYVIMRC<cr>')
-- Page-up and Page-down.
map ('n','<c-u>','<c-u>zz')
map ('n','<c-d>','<c-d>zz')
map ('n','H','I')
map ('n','L','A')
map ('n','U','<c-r>')
-- Duplicate current line
-- map ('n','<c-o>','yyp')

-- Fold-toggle current
map ('n','<space>;','za')
--" Fold-toggle all
map ('n','<space>o',"&foldlevel ? 'zM' : 'zR'", {expr=true})

-- Indent and un-indent in visual mode.
map ('v','<tab>;','>gv')
map ('v','<s-tab>;','<gv')
-- Keep selection when indenting.
map ('v','>','>gv')
map ('v','<','<gv')

-- Use <Tab> and <S-Tab> to navigate through popup menu
map ('i', '<tab>', 'pumvisible() ? "<c-n>" : "<tab>"', {expr=true})
map ('i', '<s-tab>', 'pumvisible() ? "<c-p>" : "<s-tab>"', {expr=true})


---- BUFFER MANAGEMENT ----

-- Previous and next.
map ('n','<space>bp',':bp<cr>')
map ('n','<space>bn',':bn<cr>')
-- Select a buffer to edit.
map ('n', '<space>bb', telescope_builtin.buffers)
-- Edit previous buffer (Toggle between current and alternate buffer).
map ('n','<space><tab>',':edit #<cr>')
-- Delete current buffer.
map ('n','<space>bd',':bd<cr>')
-- Delete current buffer (force)
map ('n','<space>bx',':bd!<cr>')


---- WINDOW MANAGEMENT ----

map ('n','<space>w','<c-w>')
-- Maximize.
map ('n','<space>wm','<c-w>o')
-- Horizontal and Vertical splits.
map ('n','<space>w-',':sp<cr>')
map ('n','<space>w<bar>',':vsp<cr>')
-- Close window.
map ('n','<space>q','<c-w>c')
-- Window navigation.
map ('n','<space>h','<c-w>h')
map ('n','<space>j','<c-w>j')
map ('n','<space>k','<c-w>k')
map ('n','<space>l','<c-w>l')

-- Select command from history.
map ('n','<space>hc',':NotImplemented')
-- Select file from history.
map ('n','<space>hf',':NotImplemented')
-- Select from search history
map ('n','<space>hs',':NotImplemented')

-- Autoformat code.
map ('n','<space>=',':NotImplemented')


-- Find files.
map ('n', '<space>ff', telescope_builtin.find_files)
-- Previously open files.
map ('n', '<space>fo', telescope_builtin.oldfiles)
map ('n', '<space>fh', telescope_builtin.help_tags)
-- Livegrep (async search for filenames and text)
map ('n', '<space>fl', telescope_builtin.live_grep)

-- File symbols using nvim-treesitter
map ('n', '<space>fs', telescope_builtin.treesitter)

-- Pick and run an action.
map ('n', '<space>p', alib.pick_action)
map ('n', '<C-p>', alib.pick_action)


