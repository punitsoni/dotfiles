" ====== Vim Basic Settings ====="

set nocompatible " Make incompatible with VI

"Colors"

colorscheme desert
syntax enable " enable syntax highlight

" Spaces and Tabs "

set tabstop=4 " number of visual spaces per TAB
set expandtab " tabs are spaces
set smartindent

" UI config "

set number          " show line numbers
set showcmd         " show command in bottom bar
"set cursorline      " highlight 

filetype indent on  " load filetype-specific indent files
set wildmenu        " visual autocomplete for command menu
set lazyredraw      " redraw only when we need to
set showmatch       " highlight matching [{()}]

" Searching "

set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set ignorecase

" Map a key to turn off search highlight "
nnoremap <leader><space> :nohlsearch<CR>

" Folding "

set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
" space open/closes folds
nnoremap <space> za
set foldmethod=syntax   " fold based on syntax (other options: indent marker manual expr diff)

" Leader shortcuts "

let mapleader=","       " leader is comma

" jk is escape "
inoremap jk <esc>

" key mapping for editing the *rc files "

nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>eb :vsp ~/.bashrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

""" VIM Plugin Settings

" Pathogen "
execute pathogen#infect()
syntax on
filetype plugin indent on


" --- Python Settings --- "

"execute current buffer using python by pressing F9
autocmd FileType python nnoremap <silent> <F9> :!clear; python %<CR>

" Jedi python completion plugin settings "
autocmd FileType python setlocal completeopt-=preview


