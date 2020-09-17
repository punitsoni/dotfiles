" ------------------------------------------------------------------------------
" -- Plugins ----------------------------------------------------------------{{{
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
" Highlights places where you can jump.
Plug 'easymotion/vim-easymotion'
" Support for editing with surrounding quotes, parens etc.
Plug 'tpope/vim-surround'
" Support for repeat (.) functionality for plugins.
Plug 'tpope/vim-repeat'
" Use * to search for selections.
Plug 'bronson/vim-visual-star-search'
" Fuzzy File Finder in ~/.fzf and run the install script
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Syntax Highlight for javascript
Plug 'pangloss/vim-javascript'
" React JSX syntax
Plug 'mxw/vim-jsx'
" Fancy startup screen for vim.
Plug 'mhinz/vim-startify'
" Configs for neovim builtin LSP client.
Plug 'neovim/nvim-lspconfig'
" Better diagnostics for nvim lsp
Plug 'nvim-lua/diagnostic-nvim'
" Completion for nvim lsp.
Plug 'nvim-lua/completion-nvim'


" ---- Themes ---- "

Plug 'junegunn/seoul256.vim'
Plug 'rakr/vim-one'
Plug 'reedes/vim-colors-pencil'

" ---- My plugins ---- "

" Workspace manager.
Plug 'punitsoni/wsp-vim'

" ---- Expremental ---- "

" Requirement for telescope.
" Plug 'nvim-lua/popup.nvim'
" A lua library for neovim.
" Plug 'nvim-lua/plenary.nvim'
" Fuzzy finder written in lua.
" Plug 'nvim-lua/telescope.nvim'

" Initialize all plugins.
call plug#end()

"}}}

" ------------------------------------------------------------------------------
" -- General Setup ----------------------------------------------------------{{{
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
" Disable backups.
set nobackup
set nowritebackup
" Use spaces instead of tabs.
set expandtab
" Set default indentation size.
set tabstop=2
set shiftwidth=2
" Dont show mode as airline already does.
set noshowmode
" Command-line height
set cmdheight=1
" Default coding textwidth
set textwidth=80
" Highlight the 81st column.
set colorcolumn=81
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
" Ignore these files and dirs when searchig/globbing
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pdf,*.msi,*.exe,*.a,*.o,*.bin
set wildignore+=*.out,*.deb,*/__pycache__/*
"
" set inccommand=split
" Use number colum for diagnostic signs.
set signcolumn=number
" Things should update faster.
set updatetime=1000
" Make it so there are always ten lines below my cursor
set scrolloff=10
" Better completion experience.
set completeopt=menuone,noinsert,noselect
" Avoid showing message extra message when using completion.
set shortmess+=c

" Load configuration from basics.lua module.
lua << EOF
package.loaded['basics'] = nil
bs = require('basics')
bs.init()
EOF

" ---- Setup Misc. ---- "

" `matchit.vim` is built-in so let's enable it!
" Hit `%` on `if` to jump to `else`.
runtime macros/matchit.vim

" }}}

" ------------------------------------------------------------------------------
" -- Autocommands -----------------------------------------------------------{{{
" ------------------------------------------------------------------------------

" disable automatic comment insertion
function! DisableAutoComment()
  " See :help fo-table
  setlocal formatoptions-=c
  setlocal formatoptions-=r
  setlocal formatoptions-=o
endfunction

augroup AllFileTypes
  autocmd!
  autocmd FileType * :call DisableAutoComment()
augroup END

" Jump to the last position when reopening a file
function! JumpToLastKnownPosition()
  if line("'\"") > 1 && line("'\"") <= line("$")
    exe "normal! g'\""
  endif
endfunction

augroup AllBufRead
  autocmd!
  autocmd BufRead * :call JumpToLastKnownPosition()
augroup END

function! OnTerminalEnter()
  setlocal nonumber
  startinsert
endfunction

augroup EnterTerminal
  autocmd!
  " Enter insert-mode.
  " autocmd TermOpen,BufEnter term://* startinsert
  autocmd TermOpen,BufEnter term://* :call OnTerminalEnter()
augroup END

function! OnTerminalClose()
  bdelete!
  " If this is not last window, close it.
  if winbufnr(2) != -1
    close
  endif
endfunction

augroup TerminalClosed
  autocmd!
  autocmd TermClose term://* :call OnTerminalClose()
augroup END


"}}}

" ------------------------------------------------------------------------------
" -- Appearance and Themes --------------------------------------------------{{{
" ------------------------------------------------------------------------------

" Enable truecolor.
set termguicolors
" Set background dark or light for different versions of the theme.
set background=dark
" highlight cursor line
set cursorline

" if v:lua.bs.has_colorscheme('one')
"   let g:one_allow_italics = 1
"   let g:airline_theme = 'one'
"   colorscheme one
" endif

if v:lua.bs.has_colorscheme('pencil')
  let g:pencil_terinal_italics = 1
  let g:airline_theme = 'pencil'
  colorscheme pencil
endif

" if v:lua.bs.has_colorscheme('neo')
"   colorscheme neo
" endif

" Better colors for matchparen highlight
highlight MatchParen gui=underline guibg=none guifg=yellow
" }}}

" ------------------------------------------------------------------------------
" -- keybindings ------------------------------------------------------------{{{
" ------------------------------------------------------------------------------
" set space as the map leader key
let mapleader="\<space>"
" Space-space = clear search highlight
nnoremap <space>, :noh<CR>:echo ""<CR>
" Edit vimrc file in split
nnoremap <leader>ev :edit $MYVIMRC<cr>
" Reload vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>
" Better keymap to exit insert mode
inoremap jk <esc>
" Better shortcuts for pg-up and pg-down.
nnoremap <c-k> <c-u>zz
nnoremap <c-j> <c-d>zz
" Better line append.
nnoremap L A
" Symmetric shortcut for redo (undo-undo)
nnoremap U <c-r>
" Quit.
nnoremap <leader>x :q<cr>
" Save (write) buffer to file.
nnoremap <c-s> :w<cr>
" Write current file and exit.
nnoremap <c-q> ZZ

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
" Some extra keybindings for window navigation in normal mode.
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

" -- Buffer management <leader>-b
" Next buffer
nnoremap <leader>bn :bn<cr>
" Prev buffer
nnoremap <leader>bp :bp<cr>
" List buffers
nnoremap <leader>bb :Buffers<cr>
" Edit previous buffer.
nnoremap <leader><tab> :edit #<cr>
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
" nnoremap <leader>ll :Autoformat<cr>
" Prevent entering Ex mode accidentally
nnoremap Q <Nop>
" Tab/Shift-Tab to indent/un-indent in visual mode.
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
" Keep selections when indenting.
vnoremap > >gv
vnoremap < <gv

" Reindent file. TO-DO: perform smarter re-formatting according to language.
nnoremap <leader>= magg=G`a:echo "File re-indented."<CR>

" ---- Terminal ----
" Open terminal
nnoremap <silent> <C-t> :lua bs.termbelow()<cr>
" Kill terminal and close the window.
tnoremap <C-q> <C-\><C-n>:bdelete!<cr>
" Enter normal mode.
tnoremap <C-e> <C-\><C-n>
" Enter normal mode.
tnoremap <leader><esc> <C-\><C-n>


"}}}

" ------------------------------------------------------------------------------
" -- Experiments ------------------------------------------------------------{{{
" ------------------------------------------------------------------------------

set pumblend=17
" Makes floating PopUpMenu for completing stuff on the command line.
set wildoptions+=pum
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" }}}

" ------------------------------------------------------------------------------
" -- Notes ------------------------------------------------------------------{{{
" ------------------------------------------------------------------------------

" Install python lsp server
" python3 -m pip 'python-language-server[all]'

" Reloading an existing module.
" lua package.loaded['nlua.ftplugin'] = nil
" Good explanation of autocommands.
" https://developer.ibm.com/tutorials/l-vim-script-5/

" ---- TO-DO ---- "
" * Better color highlighting for vim-startify
" * Check for coc.nvim requirements (vim version, node etc.)
" * Open help and documentation in floating window.
" * Move more config to lua as possible.


" ---- Remember ---- "
" * Put filetype specific settings in ftplugin/<ft>.vim files.

" }}}
