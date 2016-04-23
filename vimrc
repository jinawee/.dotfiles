
"Preamble{{{
" Use pathogen
execute pathogen#infect()
call pathogen#helptags() " generate helptags for everything in 'runtimepath'
syntax on           "syntax highlight
filetype plugin on  
filetype indent on
set nocompatible "vi is dead! Long live vim!
set modelines=0  "Security reasons
"set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/
"}}}

set t_Co=256    "terminal colors
set encoding=utf-8  "always us utf-8 encoding
set scrolloff=3     "show at least three lines above and below the cursor
set autoindent
set showmode
set showcmd
set hidden
" No alerts
set noerrorbells
set visualbell
set t_vb="
set ttyfast
set ruler   "show coordinates cursor
set backspace=indent,eol,start
set laststatus=2
set relativenumber    "display line number relative to cursor
"set undofile
set confirm   "ask for confirmation
"Decimal numbers
set nrformats=
set history=1000
set undolevels=1000   
set spelllang=es


"Save with root permission
cmap w!! w !sudo tee > /dev/null %

au FocusLost * :wa

let mapleader =","
inoremap jk <Esc> 

" Highlight dark background
set background=dark

"Change tab behaviour{{{
set tabstop=2 "visual spaces per tab
set shiftwidth=2
set softtabstop=2   "spaces per tab when editing
set expandtab   "tabs are spaces
set smarttab
"}}}

"Folding{{{
set foldenable  "enable folding
set foldlevelstart=5 "most folds open
set foldmethod=indent
"}}}

"Tab completion{{{
set wildmenu
set wildmode=list:longest
"}}}

"Useful search options{{{
nnoremap / /\v
vnoremap / /\v
" Ignore case
set ignorecase
" Unless using cases
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
" No highlight
nnoremap <leader><space> :noh <cr> 
"Go to matching parentheses with tab
nnoremap <tab> %
vnoremap <tab> %
"}}}

"Handle long lines{{{
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=95
"}}}

"Movement{{{

"Allow mouse
set mouse=a

"Move vertically by visual line
nnoremap j gj
nnoremap k gk

"}}}

"Insert{{{
"One character insert with space
nmap <space> i <esc>r

"Insert blank line
map <Enter> O<ESC>
map <leader><Enter> o<ESC>
"}}}

"Copy/pasting{{{
"Paste mode with F12
set pastetoggle=<F12>

"Clipboard system
set clipboard=unnamedplus
"}}}


"let g:jedi#auto_initialization = 0
autocmd FileType python setlocal completeopt-=preview

"Highlight last inserted text
nnoremap gV `[v`]

"Edit/reload vimrc
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>rv :so $MYVIMRC<CR>

"Swap directory
set backup
set backupdir=~/.vim/backup//
set directory=~/.vim/swp//
"set backupdir=./.backup,.,/tmp
"set directory=.,./.backup,/tmp

"Save and run python script
nnoremap <silent> <leader>rp :w \| !python %<CR>

"Toggle gundo
nnoremap <leader>u :GundoToggle<CR>

""""""""""""""PLUG-INS""""""""""""""
"Rainbow parentheses{{{
let g:rainbow_conf = {
\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\	'ctermfgs': ['darkgray', 'darkblue', 'darkmagenta', 'darkcyan'],
\	'operators': '_,_',
\	'parentheses': [['(',')'], ['\[','\]'], ['{','}']],
\	'separately': {
\		'*': {},
\		'lisp': {
\			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
\			'ctermfgs': ['darkgray', 'darkblue', 'darkmagenta', 'darkcyan', 'darkred', 'darkgreen'],
\		},
\		'vim': {
\			'parentheses': [['fu\w* \s*.*)','endfu\w*'], ['for','endfor'], ['while', 'endwhile'], ['if','_elseif\|else_','endif'], ['(',')'], ['\[','\]'], ['{','}']],
\		},
\		'tex': {
\			'parentheses': [['(',')'], ['\[','\]'], ['\\begin{.*}','\\end{.*}']],
\		},
\		'css': 0,
\		'stylus': 0,
\	}
\}

nmap <leader>p :RainbowToggle <CR>
"}}}

"Syntastic{{{
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"
"let g:syntastic_python_checkers = ['pyflakes']
""}}}

" Supertab {{{
let g:SuperTabDefaultCompletionType = "context"

function! MyTagContext()
    let line = getline('.')
    let pos = col('.')
    let line_start = line[:pos-1]
    if line_start =~ '\C\\cite\(p\|t\)\?\*\?\_\s*{\(\S*:*\S*,*\)*\s*' . '$' || line_start =~ '\C\\v\?\(eq\|page\)\?ref\*\?\_\s*{\(\S*:*\S*,*\)*\s*' . '$'
        return "\<c-x>\<c-o>"
    elseif line_start =~ '\\\w*$'
        return "\<c-x>\<c-k>"
    elseif line_start =~ '\\\includegraphics\S*{$' || line_start =~ '\\\input\S*{$' 
        return "\<c-x>\<c-f>"
    endif
    " no return will result in the evaluation of the next
    " configured context
endfunction

let b:SuperTabCompletionContexts = ['MyTagContext', 's:ContextText']
"}}}

" Solarized {{{
syntax enable
"set background=dark " dark|light "
"colorscheme solarized
"}}}

" Powerline {{{
let g:airline_powerline_fonts = 1
"powerline symbols
if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif
"}}}

" Airline {{{
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = ''
"}}}

let g:Tex_Env_equation = "\\begin{equation}\<CR><++>\<CR>\\end{equation}<++>"

"Fold this .vimrc
set modelines=1
" vim:foldmethod=marker:foldlevel=0
