set nocompatible
syntax enable
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
