set nocompatible
filetype indent plugin on
syntax on
set shiftwidth=4
set softtabstop=4
set expandtab
set mouse=a
set background=dark
colorscheme gruvbox
"set transparency=5
set nofoldenable
execute pathogen#infect()
filetype on
set number
set ignorecase
set smartcase
map ` :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
set colorcolumn=100
filetype plugin on
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menuone
set hidden
let g:racer_cmd = "/usr/local/bin/racer"
let $RUST_SRC_PATH="/usr/local/src/rust/src"
autocmd BufWritePost *.hs GhcModCheckAndLintAsync
set fillchars+=vert:│
au BufRead,BufNewFile *.syn set filetype=ocaml
au BufRead,BufNewFile *.smt set filetype=lisp
autocmd FileType rust,scala,ocaml autocmd BufWritePre <buffer> :%s/\s\+$//e
autocmd FileType scala,c :setlocal sw=2 sts=2
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//
