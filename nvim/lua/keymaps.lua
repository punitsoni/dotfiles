
-- Helper function for keymapping.
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then 
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Avoid entering Ex mode accidentally.
map ('n','Q','<nop>')
-- Clear search high-light.
map ('n','<space><space>',':noh<cr>:echo ""<cr>')
map ('n','<space>ev',':edit $MYVIMRC<cr>')
map ('n','<space>sv',':source $MYVIMRC<cr>' )
-- Page-up and Page-down.
map ('n','<c-k>','<c-u>zz' )
map ('n','<c-j>','<c-d>zz' )
map ('n','H','I' )
map ('n','L','A' )
map ('n','U','<c-r>' )
-- Duplicate current line
map ('n','<c-o>','yyp' )

-- Fold-toggle current
map ('n','<space>;','za' )
--" Fold-toggle all
map ('n','<space>o',"&foldlevel ? 'zM' : 'zR'", {expr=true})

-- Indent and un-indent in visual mode.
map ('v','<tab>;','>gv' )
map ('v','<s-tab>;','<gv' )
-- Keep selection when indenting.
map ('v','>','>gv' )
map ('v','<','<gv' )

-- Use <Tab> and <S-Tab> to navigate through popup menu
map ('i', '<tab>', 'pumvisible() ? "<c-n>" : "<tab>"', {expr=true})
map ('i', '<s-tab>', 'pumvisible() ? "<c-p>" : "<s-tab>"', {expr=true})


---- BUFFER MANAGEMENT ----

-- Previous and next.
map ('n','<space>bp',':bp<cr>' )
map ('n','<space>bn',':bn<cr>' )
-- Select a buffer to edit.
map ('n','<space>bb',':Telescope buffers<cr>' )
-- Edit previous buffer.
map ('n','<space><tab>',':edit #<cr>' )
-- Delete current buffer.
map ('n','<space>bd',':bd<cr>' )
-- Delete current buffer (force)
map ('n','<space>bx',':bd!<cr>' )


---- WINDOW MANAGEMENT ----

map ('n','<space>w','<c-w>' )
-- Maximize.
map ('n','<space>wm','<c-w>o' )
-- Horizontal and Vertical splits.
map ('n','<space>w-',':sp<cr>' )
map ('n','<space>w<bar>',':vsp<cr>' )
-- Close window.
map ('n','<space>q','<c-w>c' )
-- Window navigation.
map ('n','<leader>h','<c-w>h' )
map ('n','<leader>j','<c-w>j' )
map ('n','<leader>k','<c-w>k' )
map ('n','<leader>l','<c-w>l' )


-- Select command from history.
map ('n','<space>hc',':NotImplemented' )
-- Select file from history.
map ('n','<space>hf',':NotImplemented' )
-- Select from search history
map ('n','<space>hs',':NotImplemented' )
-- Find files.
map ('n','<space>ff',':Telescope find_files<cr>' )

-- Autoformat code.
map ('n','<space>=',':NotImplemented' )

