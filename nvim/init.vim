" ------------------------------------------------------------------------------
" -- Plugin Management #plugins ---------------------------------------------{{{
" ------------------------------------------------------------------------------

" Path to the plugin location. stdpath("data") points to ~/.local/share/nvim
let g:plugdir = stdpath("data") . "/plugged"

" Begin listing the plugins to load.
call plug#begin(g:plugdir)

" Let plug manage plug.
Plug 'junegunn/vim-plug'
" Commenting code in various languages.
Plug 'tpope/vim-commentary'
" A better status line with themes.
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" insert or remove brackets, parens, quotes etc. in pair
" Plug 'jiangmiao/auto-pairs'
" Support for editing with surrounding quotes, parens etc.
Plug 'tpope/vim-surround'
" Support for repeat (.) functionality for plugins.
Plug 'tpope/vim-repeat'
" Use * to search for selections.
Plug 'bronson/vim-visual-star-search'
" Fuzzy File Finder in ~/.fzf and run the install script
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Autocomplete engine for neovim.
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Syntax Highlight for javascript
Plug 'pangloss/vim-javascript'
" React JSX syntax
Plug 'mxw/vim-jsx'
" Official LSP plugin
Plug 'neovim/nvim-lsp'
" Fancy startup screen for vim.
Plug 'mhinz/vim-startify'
" Themes
Plug 'junegunn/seoul256.vim'
Plug 'rakr/vim-one'
Plug 'reedes/vim-colors-pencil'

" My plugins.
Plug 'punitsoni/basics-vim'
Plug 'punitsoni/wsp-vim'

" Local plugins.
Plug g:plugdir . '/whid-vim'

" Initialize all plugins.
call plug#end()
"}}}

" ------------------------------------------------------------------------------
" -- General Options #general -----------------------------------------------{{{
" ------------------------------------------------------------------------------
" Enable filetype based plugin and indents
filetype plugin indent on
" Syntax highlighing on
syntax on
" Highlight search term as you type.
set hlsearch
" Proper backspace behavior.
" set backspace=indent,eol,start
" Incremental search, hit `<CR>` to stop.
set incsearch
" Show current command in statusbar
set showcmd
" Enable mouse
set mouse=a
" Ignore case while searching
set ignorecase
" Do not create swap files
set noswapfile
" keep buffers loaded when window closes, required by many plugins.
set hidden
" Shows the current line number at the bottom-right of the screen.
set ruler
" Use spaces instead of tabs.
set expandtab
" Set default indentation size.
set tabstop=2
set shiftwidth=2
" Dont show mode as airline already does.
set noshowmode
" Default coding textwidth
set textwidth=80
" No automatic wrapping of lines.
set nowrap
" Use » to mark Tabs and ° to mark trailing whitespace
set list listchars=tab:»\ ,trail:°
" Enable line-numbers
set number
" Use non-retarded locations when opening new splits.
set splitbelow
set splitright
" Show completion options in a menu.
set wildmenu
" Use system clipboard
set clipboard=unnamed
" Set the tab-completion for commands to be more similar to shell
set wildmode=longest:full,full
" Ignore these files / dirs when searchig/globbing
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pdf,*.msi,*.exe,*.a,*.o,*.bin,*.out,*.deb
set wildignore+=*/__pycache__/*
"
set inccommand=split
" Jump to the last position when reopening a file
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" Clear search-highlight when reloading vimrc.
noh
" disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" `matchit.vim` is built-in so let's enable it!
" Hit `%` on `if` to jump to `else`.
runtime macros/matchit.vim
"}}}

" ------------------------------------------------------------------------------
" -- Appearance and Themes #themes ------------------------------------------{{{
" ------------------------------------------------------------------------------

" Enable truecolor.
set termguicolors
" Set background dark or light for different versions of the theme.
set background=dark

" highlight cursor line
set cursorline

" Checks if a colorscheme exists.
function! HasColorscheme(name) abort
    let pat = 'colors/'.a:name.'.vim'
    return !empty(globpath(&rtp, pat))
endfunction

" if HasColorscheme('one')
"   let g:one_allow_italics = 1
"   let g:airline_theme = 'one'
"   colorscheme one
" endif

" if HasColorscheme('seoul256')
"   let g:seoul256_background = 234
"   colorscheme seoul256
" endif

if HasColorscheme('pencil')
  let g:pencil_terminal_italics = 1
  let g:airline_theme = 'pencil'
  colorscheme pencil
endif

" Better colors for matchparen highlight
hi MatchParen cterm=underline ctermbg=none ctermfg=yellow
"}}}

" ------------------------------------------------------------------------------
" -- Plugin configurations #configplugins -----------------------------------{{{
" ------------------------------------------------------------------------------

" -- Deoplete config -- "
let g:deoplete#enable_at_startup = 1
" " Use tab key for completion
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" -- Airline config -- "
" Currently, This does not seem to work.
let g:airline_exclude_filetypes = ['Terminal']
"}}}

" ------------------------------------------------------------------------------
" -- Custom key bindings #keys ----------------------------------------------{{{
" ------------------------------------------------------------------------------
" set space as the map leader key
let mapleader="\<space>"
" Space-space = clear search highlight
nnoremap <leader><space> :noh<CR>:echo ""<CR>
" Edit vimrc file in split
nnoremap <leader>ev :edit $MYVIMRC<cr>
" Reload vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>
" Better keymap to exit insert mode
inoremap  jk <esc>
" Better shortcuts for pg-up and pg-down.
nnoremap K <c-u>zz
nnoremap J <c-d>zz
" Symmetric shortcut for redo (undo-undo)
nnoremap U <c-r>
" Quit.
nnoremap <leader>x :q<cr>
" Save (write) buffer to file.
nnoremap <leader>s :w<cr>

" --- Window management <leader>-w
" Add leader-w prefix for all window commands.
nnoremap <leader>w <c-w>
" Maximize current window
nnoremap <leader>wm <c-w>o
" Vertical split
nnoremap <leader>w<bar> :vsp<cr>
" Horizontal split
nnoremap <leader>w- :sp<cr>
" Close window.
nnoremap <leader>q <c-w>c
" Force-close buffer and close window or exit.
nnoremap <C-q> :bd!<cr>ZZ

" Use Ctrl-[hjkl] to navigate windows in all modes.
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" -- Buffer management <leader>-b
" Next buffer
nnoremap <leader>bn :bn<cr>
" Prev buffer
nnoremap <leader>bp :bp<cr>
" List buffers
nnoremap <leader>bb :Buffers<cr>
" Delete current buffer
nnoremap <leader>bd :bd<cr>
" Delete current buffer (force)
nnoremap <leader>bx :bd!<cr>

" Fold-toggle current
nnoremap <leader>; zazz0
" Fold-toggle all
nnoremap <expr> <leader>o &foldlevel ? 'zMzz0' :'zRzz0'
" Command history
nnoremap <leader>hc :History:<cr>
" File history
nnoremap <leader>hf :History<cr>
" Search history
nnoremap <leader>hs :History/<cr>
" Automatically format code
nnoremap <leader>ll :Autoformat<cr>
" Prevent entering Ex mode accidentally
nnoremap Q <Nop>
" Tab/Shift-Tab to indent/un-indent in visual mode.
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
" Keep selections when indenting.
vnoremap > >gv
vnoremap < <gv

" Reindent file. TODO: perform smarter re-formatting according to language.
nnoremap <leader>= magg=G`a:echo "File re-indented."<CR>

" ---- Terminal ----
" Kill terminal and close the window.
tnoremap <C-q> <C-\><C-n>:bdelete!<cr>
" Enter normal mode.
tnoremap <C-e> <C-\><C-n>
" Easy switch to normal mode in terminal
tnoremap <leader><esc> <C-\><C-n>0

"}}}

" ------------------------------------------------------------------------------
" -- Experimental stuff #experiments ----------------------------------------{{{
" ------------------------------------------------------------------------------
" Put experimental settings here.

" Inline Lua code.
lua << EOF

-- Get basics module in global namespace.
bs = require('basics')

-- TODO: configure LSP settings.

function open_terminal()
    vim.api.nvim_command('12split | terminal')
end

EOF

" Open terminal
nnoremap <C-t> :lua open_terminal()<cr>

" let g:fzf_layout = { 'window': 'lua require("test").NavigationFloatingWin()' }
" Floating window for all FZF operations.
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.5 } }

" Enter insert-mode when opening or switching to a terminal
autocmd TermOpen,BufEnter term://* startinsert
" }}}

" ------------------------------------------------------------------------------
" -- TODOs ------------------------------------------------------------------{{{
" ------------------------------------------------------------------------------

" * Better color highlighting for vim-startify

" }}}
