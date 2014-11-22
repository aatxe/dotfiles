set nocompatible
filetype indent plugin on
syntax on
set shiftwidth=4
set softtabstop=4
set expandtab
set mouse=a
colorscheme torte
execute pathogen#infect()
filetype on
au BufNewFile,BufRead *.rs set filetype=rust
set number
set ignorecase
set smartcase
map ` :NERDTreeToggle<CR>
map B :! cargo build<CR>
map T :! cargo test<CR>
autocmd vimenter * NERDTree
