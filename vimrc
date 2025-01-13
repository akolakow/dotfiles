syntax on
set wildmenu
set number
set hlsearch

set tabstop=2
set shiftwidth=2
set expandtab

set updatetime=100 "vimgutter update time is based on it

set noswapfile

set t_Co=256

set completeopt-=preview    "scratch disable

set mouse=a

set clipboard=unnamed

"Vundle
set nocompatible              " be iMproved
filetype off                  " required!

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()

Plug 'ycm-core/YouCompleteMe'
Plug 'preservim/nerdtree'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-unimpaired'
Plug 'bronson/vim-trailing-whitespace'
Plug 'bling/vim-airline'
Plug 'preservim/nerdcommenter'
Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'


Plug 'aklt/plantuml-syntax'
Plug 'nanotech/jellybeans.vim'
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'

Plug 'majutsushi/tagbar'
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'kergoth/vim-bitbake'

Plug 'vim-scripts/a.vim'

Plug 'plasticboy/vim-markdown'
Plug 'elzr/vim-json'
Plug 'chr4/nginx.vim'
Plug 'fatih/vim-go'
Plug 'isobit/vim-caddyfile'
Plug 'MTDL9/vim-log-highlighting'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

call plug#end()            " required!
filetype plugin indent on    " required!

let mapleader=" "
nnoremap <SPACE> <Nop>

"airline
let g:airline_powerline_fonts = 0
let g:airline_theme='gruvbox'

"nerdtree
let g:NERDTreeWinPos = "right"

"ycm
let g:ycm_key_list_stop_completion = ['<C-y>', '<CR>']
" Let clangd fully control code completion
let g:ycm_clangd_uses_ycmd_caching = 0
let g:ycm_clangd_args = ['-log=verbose', '-pretty']
let g:ycm_auto_hover=''

"let g:nerdtree_tabs_open_on_console_startup = 1
map <F2> :NERDTreeToggle<CR>
map <F3> :NERDTreeFind<CR>

" switch source/header a.vim
map <F4> :A<CR>

" refresh all buffers
map <F5> :checktime<CR>

" build shortcut
map <F6> :make<CR> :cw<CR>

map <F7> :setlocal spell! spelllang=pl<CR>

"clang format"
map <F8> :YcmCompleter Format<CR>

map <F9> :TagbarToggle<CR>

"fzf
"if has('macunix')
  "set rtp+=/usr/local/bin/fzf
"else
  "set rtp+=~/.fzf
"endif
noremap <C-P> :Files<CR>
nnoremap <leader><leader> :Files<CR>
nnoremap <leader>/ :RG<CR>

" easy buffer navigation
noremap <C-Left> <C-w>h
noremap <C-Down> <C-w>j
noremap <C-Up> <C-w>k
noremap <C-Right> <C-w>l

set timeout timeoutlen=1000 ttimeoutlen=100

map <C-S-Right> :tabn<cr>
map <C-S-Left> :tabp<cr>

"current line highlighted
set cursorline

" line movements
set <F15>=[1;3B "Alt down
set <F16>=[1;3A "Alt up
nnoremap <silent> <F15> :m .+1<CR>==
nnoremap <silent> <F16> :m .-2<CR>==
inoremap <silent> <F15> <ESC>:m .+1<CR>==gi
inoremap <silent> <F16> <ESC>:m .-2<CR>==gi
vnoremap <silent> <F15> :m '>+1<CR>gv=gv
vnoremap <silent> <F16> :m '<-2<CR>gv=gv

" keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz
nnoremap <c-o> <c-o>zz

"YouCompleteMe
nnoremap <leader>f :YcmCompleter FixIt<CR>
nnoremap <silent> <leader>rn <cmd>execute 'YcmCompleter RefactorRename' input( 'Rename to: ' )<CR>
"old one
nnoremap <leader>g :YcmCompleter GoTo<CR>
nnoremap gd :YcmCompleter GoTo<CR>
nnoremap <C-LeftMouse> <LeftMouse>:YcmCompleter GoTo<CR>
"old one
nnoremap <leader>gr :YcmCompleter GoToReferences<CR>
nnoremap gr :YcmCompleter GoToReferences<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gi :YcmCompleter GoToInclude<CR>
nnoremap <leader>gt :YcmCompleter GetType<CR>
nnoremap <leader>gh :YcmCompleter RefactorRename
nnoremap <leader>gd :YcmDiags<CR>
nmap <leader>ss <Plug>(YCMFindSymbolInWorkspace)
nmap <leader>bt <Plug>(YCMCallHierarchy)
nmap <leader>h <plug>(YCMHover)

"vim-json
setlocal foldmethod=syntax
au FileType json setlocal equalprg=json_pp

set colorcolumn=+1

colorscheme gruvbox
set background=dark


"json
nnoremap <leader>j :%!jq .<CR> :set syntax=json<CR>

set foldlevelstart=9999


" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<c-s>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"


" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
