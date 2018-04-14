syntax on
set wildmenu
set number
set hlsearch

set smartindent
set tabstop=4
set shiftwidth=4
"set expandtab

set noswapfile

set t_Co=256

set completeopt-=preview    "scratch disable

set mouse=a

set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

set clipboard=unnamed

"set list


Bundle 'gmarik/Vundle.vim'
Bundle 'scrooloose/nerdtree'
"Bundle 'octol/vim-cpp-enhanced-highlight'
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'kien/ctrlp.vim'
Bundle 'mileszs/ack.vim'
Bundle 'rking/ag.vim'
Bundle 'tyok/nerdtree-ack'
Bundle 'tpope/vim-sensible'
Bundle 'bronson/vim-trailing-whitespace'
Bundle 'bling/vim-airline'
Bundle 'scrooloose/nerdcommenter'
Bundle 'vim-syntastic/syntastic'
Bundle 'tpope/vim-fugitive'
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'
Bundle 'xaizek/vim-inccomplete'

Bundle 'davidhalter/jedi-vim'

Bundle 'aklt/plantuml-syntax'
Bundle 'nanotech/jellybeans.vim'
Bundle 'tomasr/molokai'
Bundle 'morhetz/gruvbox'

Bundle 'majutsushi/tagbar'
Bundle 'benmills/vimux'
Bundle 'christoomey/vim-tmux-navigator'

call vundle#end()            " required!
filetype plugin indent on    " required!

"airline
let g:airline_powerline_fonts = 0
let g:airline_theme='gruvbox'

"nerdtree
let g:NERDTreeWinPos = "right"
"let g:nerdtree_tabs_open_on_console_startup = 1
map <F2> :NERDTreeTabsToggle<CR>
map <F3> :NERDTreeFind<CR>


map <F4> :MatchmakerToggle<CR>


" refresh all buffers
map <F5> :checktime<CR>

" build shortcut
map <F6> :make<CR> :cw<CR>



map <F7> :setlocal spell! spelllang=pl<CR>

"clang format"
map <F8> :ClangFormat<CR>

map <F9> :TagbarToggle<CR>

"CtrlP
let g:ctrlp_max_files = 0
let g:ctrlp_custom_ignore = 'build'
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:50'

" easy buffer navigation
"noremap <C-Left> <C-w>h
"noremap <C-Down> <C-w>j
"noremap <C-Up> <C-w>k
"noremap <C-Right> <C-w>l

set timeout timeoutlen=1000 ttimeoutlen=100
set <F13>=[1;6D
set <F14>=[1;6C
map <F13> <C-S-Left>
map! <F13> <C-S-Left>
map <F14> <C-S-Right>
map! <F14> <C-S-Right>

map <C-S-Right> :tabn<cr>
map <C-S-Left> :tabp<cr>


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
" set so=999
" nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>


" clang complete
"let g:clang_auto_select=1
"let g:clang_complete_auto=1
"let g:clang_hl_errors=0
"let g:clang_complete_macros=1
"let g:clang_use_library=1
"let g:clang_user_options='|| exit 0'
"let g:clang_jumpto_back_key='<leader>['
"let g:clang_jumpto_declaration_key='<leader>]'
"let g:clang_library_path='/usr/lib/llvm-3.5/lib'
"set completeopt=longest,menuone
"let g:clang_auto_user_options='compile_commands.json'



"nmap <leader>rt :tab split<CR><leader>rj



 " syntastic
let g:syntastic_cpp_compiler='clang++'
let g:syntastic_cpp_compiler_options=' -std=c++11'
let g:syntastic_cpp_check_header=1
let g:syntastic_cpp_remove_include_errors=1
let g:syntastic_cpp_config_file='.clang_complete'
let g:syntastic_c_config_file='.clang_complete'
let g:syntastic_enable_highlighting=0
let g:syntastic_cpp_clang_check_post_args=''
let g:syntastic_cpp_clang_tidy_post_args=''


" ctrl-space autocompletion
if has("gui_running")
    " c-space seems to work under gVim on both Linux and win32
    inoremap <c-space> <c-x><c-u>
else " no gui
  if has("unix")
    inoremap <nul> <c-x><c-u>
  else
  " no idea of the name of ctrl-space elsewhere
  endif
endif

set textwidth=80
set colorcolumn=+1



" pyjedi
let g:jedi#auto_vim_configuration = 0

set completeopt-=preview

"hi default Matchmaker  ctermbg=82 ctermfg=16

colorscheme gruvbox
set background=dark

