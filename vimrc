"filetype off

"Plugins
"Pathogen
execute pathogen#infect()
call pathogen#helptags() " generate helptags for everything in 'runtimepath'
syntax on
filetype plugin on
filetype indent on

set nocompatible
set modelines=0

set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/

" " Use 256 colours (Use this setting only if your terminal supports 256
" colours)
set t_Co=256
"
"Change tab behaviour
set tabstop=8
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab

set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden

"Tab completion
set wildmenu
set wildmode=list:longest

set noerrorbells
set visualbell
set t_vb=
"set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set relativenumber
"set undofile
set confirm

let mapleader =","

"Useful search option
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
"nnoremap <tab> %
"vnoremap <tab> %

"Handle long lines
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85

"Only move with hjkl
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

"Decimal numbers
set nrformats=

au FocusLost * :wa

inoremap jk <Esc> 

nmap <space> i <esc>r

"Edit/reload vimrc
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
