" ====== Vim Basic Settings ====="

set nocompatible " Make incompatible with VI

" Pathogen Initialization "
call pathogen#infect()
filetype plugin indent on

"Colors"

syntax enable " enable syntax highlight
set t_Co=16
set background=dark
colorscheme solarized

" Spaces and Tabs "

set tabstop=4 " number of visual spaces per TAB
set expandtab " tabs are spaces
set smartindent

" UI config "

set number          " show line numbers
set showcmd         " show command in bottom bar
"set cursorline      " highlight 
set splitright
set mouse=a         "enable mouse in all modes

filetype indent on  " load filetype-specific indent files
set wildmenu        " visual autocomplete for command menu
set lazyredraw      " redraw only when we need to
set showmatch       " highlight matching [{()}]

" Searching "

set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set ignorecase

" Custom Key Bindings "

let mapleader=","       " leader is comma
" Open vimrc in hsplit
nmap <leader>i :vsp $MYVIMRC<CR>
" Map a key to turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
" Open notes file in vsplit
nmap <leader>n :vsp ~/notes.md<CR>

"-- Folding -- (TODO)" 
"set foldenable          " enable folding
"set foldlevelstart=10   " open most folds by default
"set foldnestmax=10      " 10 nested fold max
" space open/closes folds
"nnoremap <space> za
"set foldmethod=syntax   " fold based on syntax (other options: indent marker manual expr diff)

"-- CTAGS settings --"

" open definition in vsplit
map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
set tags=./tags;/ "search for tags in pwd first, if not go up to root

"-- YouCompleteMe Settings --"
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"

" --- Python Settings --- "

"execute current buffer using python by pressing F9
autocmd FileType python nnoremap <silent> <F9> :!clear; python %<CR>

" Jedi python completion plugin settings "
autocmd FileType python setlocal completeopt-=preview

"-- Auto reload vimrc on save --"
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

"-- Remember last position in file when reopening --"
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
