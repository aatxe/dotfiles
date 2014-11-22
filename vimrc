set nocompatible
filetype indent plugin on
syntax on
set shiftwidth=4
set softtabstop=4
set expandtab
set mouse=a
set background=dark
colorscheme gruvbox
execute pathogen#infect()
filetype on
set number
set ignorecase
set smartcase
map ` :NERDTreeToggle<CR>
map B :! cargo build<CR>
map T :! cargo test<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
set colorcolumn=100
