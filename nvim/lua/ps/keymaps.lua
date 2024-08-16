-- TODO: make sure telescope is loaded.
local telescope_builtin = require('telescope.builtin') local alib =
require('ps.actions_lib') local actions = require 'ps.actions' local util =
require 'ps.utils'

local nmap = util.nmap local vmap = util.vmap local imap = util.imap local tmap
= util.tmap

-- Avoid entering Ex mode accidentally.
nmap('Q', '<nop>')
-- Clear search high-light.
nmap('<space><space>', ':noh<cr>:echo ""<cr>', { desc = 'Clear search highlight'
})
-- Edit config file.
nmap('<space>ev', ':edit $MYVIMRC<cr>')
-- Source config file.
nmap('<space>sv', ':source $MYVIMRC<cr>')
-- Page-up and Page-down.
nmap('<c-u>', '<c-u>zz') nmap('<c-d>', '<c-d>zz')
-- nmap ('H','I') nmap ('L','A') nmap ('U','<c-r>') Duplicate current line nmap
-- ('<c-o>','yyp')

--" Fold-toggle all nmap ('<space>o',"&foldlevel ? 'zM' : 'zR'", {expr=true})

-- Indent and un-indent in visual mode.
vmap('<tab>;', '>gv') vmap('<s-tab>;', '<gv')
-- Keep selection when indenting.
vmap('>', '>gv') vmap('<', '<gv')

-- Use <Tab> and <S-Tab> to navigate through popup menu
imap('<tab>', 'pumvisible() ? "<c-n>" : "<tab>"', { expr = true })
imap('<s-tab>', 'pumvisible() ? "<c-p>" : "<s-tab>"', { expr = true })

---- BUFFER MANAGEMENT ----

local function BufNext() vim.cmd('bnext') end

local function BufPrev() vim.cmd('bnext') end

-- Previous and next.
nmap('<space>bp', ':bp<cr>') nmap('<space>,', ':bp<cr>') nmap('<space>bn',
  ':bn<cr>') nmap('<space>.', ':bn<cr>')

nmap('gp', BufPrev, { desc = "Buffer Prev" }) nmap('gn', BufNext, { desc =
  "Buffer Next" })

-- TODO These keymaps are not working. Investigate.
nmap('<c-,>', ':bp<cr>') nmap('<c-.>', ':bn<cr>')

-- Select a buffer to edit.
nmap('<space>bb', telescope_builtin.buffers)
-- Edit previous buffer (Toggle between current and alternate buffer).
nmap('<space><tab>', ':edit #<cr>')
-- Delete current buffer.
nmap('<space>bd', actions.delete_curbuf) nmap('<leader>-',
  actions.delete_curbuf)
-- Goto alternate (last-open) buffer.
nmap('<space>;', '<C-6>')



---- WINDOW MANAGEMENT ----

nmap('<space>w', '<c-w>')
-- Maximize. nmap ('<space>wm','<c-w>o') Enter window-move mode.
nmap('<space>wm', ':WinShift<cr>', { desc = 'Move current window' })
-- Horizontal and Vertical splits.
nmap('<space>w-', ':sp<cr>') nmap('<space>w<bar>', ':vsp<cr>')
-- Close window.
nmap('<space>q', '<c-w>c')
-- Window navigation. nmap('<space>h', '<c-w>h') nmap('<space>j', '<c-w>j')
-- nmap('<space>k', '<c-w>k') nmap('<space>l', '<c-w>l')

-- Find files.
nmap('<space>ff', alib.action_func('find-files'), { desc = 'Find Files' })
-- Previously open files.
nmap('<space>fo', telescope_builtin.oldfiles)

nmap('<space>fn', alib.action_func('nvim-config-files'), { desc = 'Nvim config files' })

-- Help tags.
nmap('<space>fh', telescope_builtin.help_tags, { desc = 'Help tags' })
-- Livegrep (async search for filenames and text)
nmap('<space>fl', actions.live_grep, { desc = 'Live grep' })

-- File symbols using nvim-treesitter
nmap('<space>fs', telescope_builtin.treesitter, { desc = 'Find symbols' })

nmap('<space>/', telescope_builtin.current_buffer_fuzzy_find, { desc = 'Find in current buffer.' })

nmap('<space>fg', alib.action_func('lazygit'), { desc = 'LazyGit' })

nmap('<space><space>q', alib.action_func('quit'), { desc = 'Quit neovim' })


nmap('<C-b>', actions.toggle_tree, { desc = 'Toggle File Explorer Tree' })
imap('<C-b>', actions.toggle_tree, { desc = 'Toggle File Explorer Tree' })

-- nmap ('<C-b>', actions.toggle_edgy_left, { desc = 'Toggle Left Edgebar' })

-- Center the line after jump.
nmap('<C-o>', '<C-o>zz', {}) nmap('<C-i>', '<C-i>zz', {})

nmap('<leader>tl', alib.action_func('tmux-sessions'), { desc = 'Tmux Sessions'
})

nmap('<leader>hh', ':Alpha<cr>', { desc = 'Open home page.' })


nmap('{', '<cmd>cprev<cr>zz', { desc = "Quickfix prev" }) nmap('}',
  '<cmd>cnext<cr>zz', { desc = "Quickfix next" })

-- Pick and run an action.
nmap('<space>p', alib.pick_action) nmap('<C-p>', alib.pick_action)


-- Open/Close floating terminal. nmap ('<C-n>', ':FloatermToggle main<cr>')

-- Press Esc to enter normal mode in terminal. Question: do we ever need this?
-- tmap ('<esc>', '<C-\\><C-n>')

-- Window switching for terminal mode.
tmap('<C-h>', '<C-\\><C-n><C-w>h') tmap('<C-j>', '<C-\\><C-n><C-w>j')
tmap('<C-k>', '<C-\\><C-n><C-w>k') tmap('<C-l>', '<C-\\><C-n><C-w>l')
tmap('<C-\\><C-\\>', '<C-\\><C-n>', { desc = 'Enter normal mode in terminal' })


-- nmap ('tm', function() vim.cmd'ToggleTerm size=120 direction=vertical' end,
-- {})
nmap('<C-n>', function() vim.cmd 'ToggleTerm size=120 direction=vertical' end,
  {}) tmap('<C-n>', function() vim.cmd 'ToggleTerm' end, {})

-- Code navigation --
nmap('[[', '[[zz') nmap(']]', ']]zz')

nmap('<leader>uf', "mmgggqG'm", { desc = 'Format Buffer' })

nmap('<leader>tp', function() vim.cmd 'tabprev' end, { desc = 'Tab prev' })

nmap('<leader>tn', function() vim.cmd 'tabnext' end, { desc = 'Tab next' })

nmap('<leader>dp', function() vim.diagnostic.goto_prev() end, { desc =
  'Diagnostic Prev' }) nmap('<leader>dn', function() vim.diagnostic.goto_next()
end, { desc = 'Diagnostic Next' })

nmap('<leader>le', function() vim.cmd('Navbuddy') end, { desc = 'Navbuddy' })

nmap('<leader>lh', function() vim.cmd('ClangdSwitchSourceHeader') end, { desc =
   'SwitchSourceHeader' })
 


