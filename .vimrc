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
" Bundle 'Valloric/YouCompleteMe'
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
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-fugitive'
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'
Bundle 'xaizek/vim-inccomplete'

Bundle 'davidhalter/jedi-vim'

Bundle 'qstrahl/vim-matchmaker'



filetype plugin indent on     " required!

"airline
let g:airline_powerline_fonts = 0
let g:airline_theme='powerlineish'

"nerdtree
let g:NERDTreeWinPos = "right"
"let g:nerdtree_tabs_open_on_console_startup = 1
map <F2> :NERDTreeTabsToggle<CR>
map <F3> :NERDTreeFind<CR>


map <F4> :MatchmakerToggle<CR>


" refresh all buffers
map <F5> :checktime<CR>


" build shortcut
"set makeprg=/home/akolakow/work/prefix/native/bin/crosswaf\ build
map <F6> :make<CR> :cw<CR>



map <F7> :setlocal spell! spelllang=pl<CR>

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
" set so=999
" nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>


" clang complete
let g:clang_auto_select=1
let g:clang_complete_auto=1
let g:clang_hl_errors=0
let g:clang_complete_macros=1
let g:clang_use_library=1
let g:clang_user_options='|| exit 0'
let g:clang_jumpto_back_key='<leader>['
let g:clang_jumpto_declaration_key='<leader>]'
let g:clang_library_path='/usr/lib/'
set completeopt=longest,menuone


 " syntastic
let g:syntastic_cpp_compiler='clang++'
let g:syntastic_cpp_compiler_options=' -std=c++11'
let g:syntastic_cpp_check_header=1
let g:syntastic_cpp_remove_include_errors=1
let g:syntastic_cpp_config_file='.clang_complete'
let g:syntastic_c_config_file='.clang_complete'
let g:syntastic_enable_highlighting=0

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

hi Visual                      ctermbg=0 cterm=reverse
hi CursorLine                  ctermbg=236   cterm=none
hi CursorLineNr                ctermfg=11   cterm=bold
hi LineNr                ctermfg=241
hi ColorColumn ctermbg=236 guibg=#FF0000
hi Comment       ctermfg=245
hi SpellBad ctermbg=Red ctermfg=0
hi PmenuSel ctermbg=0 cterm=reverse
hi Search ctermbg=11 ctermfg=16


hi default Matchmaker  ctermbg=82 ctermfg=16
