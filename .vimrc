syntax on
set wildmenu
set number
set hlsearch

set smartindent
set tabstop=4
set shiftwidth=4
set expandtab


set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'Rip-Rip/clang_complete'
Bundle 'scrooloose/nerdtree'
Bundle 'molokai'
Bundle 'monokai'
Bundle 'octol/vim-cpp-enhanced-highlight'
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'kien/ctrlp.vim'
Bundle 'mileszs/ack.vim'
Bundle 'rking/ag.vim'
Bundle 'tyok/nerdtree-ack'
Bundle 'tpope/vim-sensible'

filetype plugin indent on     " required!


"nerdtree
let g:NERDTreeWinPos = "right" 
"let g:nerdtree_tabs_open_on_console_startup = 1
map <F2> :NERDTreeTabsToggle<CR>


"molokai
colorscheme molokai
