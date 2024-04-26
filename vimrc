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

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'lyuts/vim-rtags'
Plugin 'preservim/nerdtree'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'mileszs/ack.vim'
Plugin 'rking/ag.vim'
Plugin 'tyok/nerdtree-ack'
Plugin 'tpope/vim-sensible'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'bling/vim-airline'
Plugin 'preservim/nerdcommenter'
Plugin 'vim-syntastic/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'xaizek/vim-inccomplete'

Plugin 'davidhalter/jedi-vim'

Plugin 'aklt/plantuml-syntax'
Plugin 'nanotech/jellybeans.vim'
Plugin 'tomasr/molokai'
Plugin 'morhetz/gruvbox'

Plugin 'majutsushi/tagbar'
Plugin 'benmills/vimux'
Plugin 'christoomey/vim-tmux-navigator'

Plugin 'junegunn/fzf'
Plugin 'kergoth/vim-bitbake'

Plugin 'vim-scripts/a.vim'

Plugin 'plasticboy/vim-markdown'
Plugin 'elzr/vim-json'
Plugin 'chr4/nginx.vim'
Plugin 'fatih/vim-go'
Plugin 'isobit/vim-caddyfile'
Plugin 'MTDL9/vim-log-highlighting'

call vundle#end()            " required!
filetype plugin indent on    " required!

"airline
let g:airline_powerline_fonts = 0
let g:airline_theme='gruvbox'

"nerdtree
let g:NERDTreeWinPos = "right"

"ycm
" Let clangd fully control code completion
let g:ycm_clangd_uses_ycmd_caching = 0
let g:ycm_clangd_args = ['-log=verbose', '-pretty']
let g:ycm_auto_hover=''

"let g:nerdtree_tabs_open_on_console_startup = 1
map <F2> :NERDTreeTabsToggle<CR>
map <F3> :NERDTreeFind<CR>

" switch source/header a.vim
map <F4> :A<CR>

" refresh all buffers
map <F5> :checktime<CR>

" build shortcut
map <F6> :make<CR> :cw<CR>

map <F7> :setlocal spell! spelllang=pl<CR>

"clang format"
map <F8> :ClangFormat<CR>

map <F9> :TagbarToggle<CR>

"fzf
if has('macunix')
	set rtp+=/usr/local/bin/fzf
else
	set rtp+=~/.fzf
endif
noremap <C-P> :FZF<CR>

" easy buffer navigation
noremap <C-Left> <C-w>h
noremap <C-Down> <C-w>j
noremap <C-Up> <C-w>k
noremap <C-Right> <C-w>l

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
nnoremap <leader>g :YcmCompleter GoTo<CR>
nnoremap <C-LeftMouse> <LeftMouse>:YcmCompleter GoTo<CR>
nnoremap <leader>gr :YcmCompleter GoToReferences<CR>
nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gi :YcmCompleter GoToInclude<CR>
nnoremap <leader>gt :YcmCompleter GetType<CR>
nnoremap <leader>gh :YcmCompleter RefactorRename 
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
