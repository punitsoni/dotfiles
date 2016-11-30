" ----------------- vundle plugin manager settings -------------------
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" Add other plugings here by github repos
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'altercation/vim-colors-solarized'
Plugin 'kien/ctrlp.vim'
Plugin 'taglist.vim'


" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on    " required

" To ignore plugin indent changes, instead use:
"filetype plugin on
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

" Pathogen Initialization "
" call pathogen#infect()
" filetype plugin indent on
syntax enable

" ---------------- nerdtree settings ------------------
"autocmd vimenter * NERDTree
" start nerdtree automatically when vim starts
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
" exit vim if nerdtree is only buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" ------ Colorscheme settings ------------
set t_Co=16
set background=dark
colorscheme solarized

" Spaces and Tabs "
set tabstop=4       " number of visual spaces per TAB
set shiftwidth=4
set expandtab       " tabs are spaces
set smartindent

" -------------------------------- UI Config ----------------------------------"

set number          " show line numbers
set showcmd         " show command in bottom bar
set showmode
set cursorline      " highlight
set splitright
set mouse=a          "enable mouse in all modes
set pastetoggle=<F2> "paste toggle key
set colorcolumn=81  "highlight column 81 for margin
set listchars=tab:>- "set tab display char
set wildmenu        " visual autocomplete for command menu
set lazyredraw      " redraw only when we need to
set showmatch       " highlight matching [{()}]
set visualbell t_vb=
set textwidth=80


" -------------------------------- Searching ----------------------------------"

set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set ignorecase
" show search highlight only in insert mode
autocmd InsertEnter * :setlocal nohlsearch
autocmd InsertLeave * :setlocal hlsearch

" Custom Key Bindings "

let mapleader=","       " leader is comma
" Open vimrc in hsplit
"nmap <leader>i :vsp $MYVIMRC<CR>
map <C-i> :tabnew $MYVIMRC<CR>
map <C-t> :tabnew<CR>
" Map a key to turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
" Open notes file in vsplit
nmap <leader>n :vsp ~/.notes.md<CR>

"-- Folding -- (TODO)"
"set foldenable          " enable folding
"set foldlevelstart=10   " open most folds by default
"set foldnestmax=10      " 10 nested fold max
" space open/closes folds
"nnoremap <space> za
"set foldmethod=syntax   " other options: indent marker manual expr diff

"---------------------------- Ctags settings ----------------------------------"

" open definition in vsplit
map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
set tags=./tags;/ "search for tags in pwd first, if not go up to root
" autogenerate tags file when saving source files
"au BufWritePost *.c,*.cpp,*.h silent! !ctags -R & "TODO

" Toggle taglist window
map <C-l> :TlistToggle<CR>
let Tlist_Use_Right_Window = 1

"-------------------------- YouCompleteMe settings ----------------------------"
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"


"---------------------------- Cscope settings ---------------------------------"
if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=0
    set cst
    set nocsverb
    " add any database in current directory
        if filereadable("cscope.out")
                 cs add cscope.out
                         " else add database pointed to by environment
                             elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
endif

nnoremap <leader>c :!cscope -Rb<CR><CR>
"---------------------------- Python settings ---------------------------------"

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

command! Kernelmode execute "set noexpandtab | set tabstop=8"
