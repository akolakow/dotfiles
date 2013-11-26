syntax on
set wildmenu
set number
set hlsearch

set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

set t_Co=256

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
Bundle 'vim-scripts/CSApprox'
Bundle 'bronson/vim-trailing-whitespace'
Bundle 'bling/vim-airline'

filetype plugin indent on     " required!

"airline
let g:airline_powerline_fonts = 0
let g:airline_theme='powerlineish'

"nerdtree
let g:NERDTreeWinPos = "right"
"let g:nerdtree_tabs_open_on_console_startup = 1
map <F2> :NERDTreeTabsToggle<CR>
map <F3> :NERDTreeFind<CR>


"molokai
colorscheme molokai


" easy buffer navigation
noremap <C-Left> <C-w>h
noremap <C-Down> <C-w>j
noremap <C-Up> <C-w>k
noremap <C-Right> <C-w>l


"current line highlighted
set cursorline



" line movements
nnoremap <silent> <a-down> :m .+1<cr>==
nnoremap <silent> <a-up> :m .-2<cr>==
inoremap <silent> <a-down> <esc>:m .+1<cr>==gi
inoremap <silent> <a-up> <esc>:m .-2<cr>==gi
vnoremap <silent> <a-down> :m '>+1<cr>gv=gv
vnoremap <silent> <a-up> :m '<-2<cr>gv=gv

" keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz
nnoremap <c-o> <c-o>zz

