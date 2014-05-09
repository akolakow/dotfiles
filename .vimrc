syntax on
set wildmenu
set number
set hlsearch

set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

set t_Co=256


set completeopt-=preview    "scratch disable

set mouse=a



set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'Rip-Rip/clang_complete'
Bundle 'scrooloose/nerdtree'
Bundle 'molokai'
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
Bundle 'scrooloose/nerdcommenter'
Bundle 'rhysd/vim-clang-format'

filetype plugin indent on     " required!

"airline
let g:airline_powerline_fonts = 0
let g:airline_theme='powerlineish'

"nerdtree
let g:NERDTreeWinPos = "right"
"let g:nerdtree_tabs_open_on_console_startup = 1
map <F2> :NERDTreeTabsToggle<CR>
map <F3> :NERDTreeFind<CR>


" refresh all buffers
map <F5> :checktime<CR>


" build shortcut
"set makeprg=/home/akolakow/work/prefix/native/bin/crosswaf\ build
map <F6> :make<CR> :cw<CR>

"clang format"
map <F8> :ClangFormat<CR>
let g:clang_format#style_options = {
    \ "AccessModifierOffset" : -4,
    \ "UseTab" : "Never",
    \ "BreakBeforeBraces" : "Allman",
    \ "AllowShortIfStatementsOnASingleLine" : "false",
    \ "AlignEscapedNewlinesLeft" : "true",
    \ "IndentCaseLabels" : "true",
    \ "ColumnLimit" : 90,
    \ "IndentWidth" : 4,
    \ "NamespaceIndentation" : "None",
    \ "MaxEmptyLinesToKeep" : 1,
    \ "PointerBindsToType" : "true",
    \ "SpaceAfterControlStatementKeyword" : "true",
    \ "SpaceBeforeAssignmentOperators" : "true",
    \ "SpaceInEmptyParentheses" : "false",
    \ "SpacesInParentheses" : "false",
    \ "Standard" : "Auto"}

"CtrlP
let g:ctrlp_max_files = 20000

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


" center cursor
"set so=999
"nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>



set textwidth=80
set colorcolumn=+1

hi Visual                      ctermbg=0 cterm=reverse
hi CursorLine                  ctermbg=236   cterm=none
hi ColorColumn ctermbg=236 guibg=#FF0000
hi Comment       ctermfg=245
