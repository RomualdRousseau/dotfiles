" General settings

set nocompatible
syntax on

" Search
set hlsearch
set incsearch
set laststatus=2


" Goog tabs for programming
set tabstop=4
set shiftwidth=4
set softtabstop=0
set expandtab

" Use mouse in vim
set mouse=a


" Plugins

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'preservim/tagbar'
Plug 'ludovicchabant/vim-gutentags'

call plug#end()


" NERDTree settings

" Keymaps
nnoremap <F3> :NERDTreeToggle<CR>


" Tagbar settings

" Keymaps
nnoremap <F4> :TagbarOpenAutoClose<CR>


" Gutentags settings

" generate datebases in my cache directory, prevent gtags files polluting my project
let g:gutentags_cache_dir = expand('~/.cache/tags')

