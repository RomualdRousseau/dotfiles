" General settings
set nocompatible
set nowrap
set termguicolors
set t_Co=256
set clipboard=unnamed

" Display cursor line
set cursorline

" Search
set hlsearch
set incsearch
set laststatus=2

" Goog tabs for programming
set ai
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" Plugins
call plug#begin()
Plug 'dylanaraps/wal.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'ap/vim-css-color'
call plug#end()

" Activate syntax coloring
silent! colorscheme wal
syntax on

" Airline settings
let g:airline_theme='base16_dracula'
let g:airline_powerline_fonts = 1

" NERDTree settings
" Keymaps
nnoremap <C-S-E> :NERDTreeToggle<CR>

