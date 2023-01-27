if &shell =~# 'fish$'
    set shell=/bin/bash
endif

" {{{ Plugins
let DATA_DIR = stdpath('data') . '/site'
if empty(glob(DATA_DIR . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.DATA_DIR.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()

Plug 'joshdick/onedark.vim'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'itchyny/lightline.vim'
Plug 'sheerun/vim-polyglot'
Plug 'editorconfig/editorconfig-vim'
Plug 'haya14busa/is.vim'

call plug#end()
" }}}

" {{{ Appearance
let g:lightline = {
    \ 'colorscheme': 'onedark',
\ }

set termguicolors

set background=dark
colorscheme onedark
" }}}

set cursorline
set report=0

set number
set noshowmode
set nomodeline

set splitbelow
set splitright

set hlsearch

set expandtab
set softtabstop=4
set shiftwidth=4
set shiftround

set clipboard=unnamedplus
set pastetoggle=<F3>

set mouse=

set backup
let &backupdir=DATA_DIR.'/backup/'
set undofile
" }}}

let mapleader = ','
nnoremap <C-Left> <C-w>h
nnoremap <C-Down> <C-w>j
nnoremap <C-Up> <C-w>k
nnoremap <C-Right> <C-w>l

command! -range=% IX call share#ix(<line1>, <line2>)
