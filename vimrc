" General settings
set nocompatible
set nowrap
set termguicolors

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

" Activate syntax coloring
syntax on

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'preservim/tagbar'
Plug 'ludovicchabant/vim-gutentags'
Plug 'ap/vim-css-color'
call plug#end()

" Airline settings
let g:airline_theme='badwolf'
let g:airline_powerline_fonts = 1

" NERDTree settings
" Keymaps
nnoremap <F3> :NERDTreeToggle<CR>

" Tagbar settings
" Keymaps
nnoremap <F4> :TagbarOpenAutoClose<CR>

" Gutentags settings
" generate datebases in my cache directory, prevent gtags files polluting my project
let g:gutentags_cache_dir = expand('~/.cache/tags')

