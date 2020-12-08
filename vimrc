"Preamble{{{
" Use pathogen
execute pathogen#infect()
call pathogen#helptags() " generate helptags for everything in 'runtimepath'

syntax on           "syntax highlight
filetype plugin on  
filetype indent on
set nocompatible "vi is dead! Long live vim!
set modelines=0  "Security reasons
"}}}

"General{{{
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
set confirm   "ask for confirmation
"Decimal numbers
set nrformats=
set history=1000
set undolevels=1000   
set spelllang=en

"Save with root permission
cmap w!! w !sudo tee > /dev/null %

au FocusLost * :wa

let mapleader =","
inoremap jk <Esc> 

" Highlight dark background
set background=dark

" Copy and delete line without carriage return
nnoremap yA m`^y$<C-o>
nnoremap dA m`^d$<C-o>

" Disable Ex
map Q <Nop>
"}}}

"Change tab behaviour{{{
set tabstop=2 "visual spaces per tab
set shiftwidth=2
set softtabstop=2   "spaces per tab when editing
set expandtab   "tabs are spaces
set smarttab
"Specific language indentation
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype c setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
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
set colorcolumn=79
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
autocmd CmdwinEnter * nnoremap <buffer> <Enter> <Enter>
map <Enter> O<ESC>
map <leader><Enter> o<ESC>
"}}}

"Copy/pasting{{{
"Paste mode with F12
set pastetoggle=<F12>

"Clipboard system
set clipboard=unnamedplus
"}}}

"Highlight last inserted text
nnoremap gV `[v`]

"Edit/reload vimrc
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>rv :so $MYVIMRC<CR>

"Swap directory{{{
set backup
set backupdir=~/.vim/backup/
"}}}

"Save and run script
nnoremap <silent> <leader>rp :w \| ! ./%<CR>

"{{{Language C

"Insert header guards{{{
"Adds the #define to protect h files when h files are created.
if has("autocmd")
    autocmd BufNewFile *.{h,hpp} call <SID>insert_c_gates()  
endif " has("autocmd")
function! s:insert_c_gates()
   let gatename = <SID>CreateNormalGateName()
   let filename = expand("%:t")
   execute "normal i#ifndef " . gatename
   execute "normal o#define " . gatename
   execute "normal Go#endif \n/* End of file " . filename . " */"
   normal kk
endfunction
function! s:CreateNormalGateName()
   let tmp = substitute(toupper(expand("%:t")), "\\.", "_", "g")
   return tmp
endfunction
"}}}

"Go beginning definition C function{{{
function! Def()
  ?^[^ \t#]
endfunction
command! Def call Def()
"}}}

"ctags and cscope search{{{
set tags=./tags,tags;$HOME
let g:ctags_statusline=1
let g:ctags_path="/home/users/jxla/magicsbas/1Hz/working/magicSBAS/af/tags"

function! Csc()
  cscope find c <cword>
endfunction
command! Csc call Csc()

function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    silent! exe "cs add " . db . " " . path
    set cscopeverbose
  " else add the database pointed to by environment variable
  elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
  endif
endfunction
au BufEnter /* call LoadCscope()

if executable('lushtags')
    let g:tagbar_type_haskell = {
        \ 'ctagsbin' : 'lushtags',
        \ 'ctagsargs' : '--ignore-parse-error --',
        \ 'kinds' : [
            \ 'm:module:0',
            \ 'e:exports:1',
            \ 'i:imports:1',
            \ 't:declarations:0',
            \ 'd:declarations:1',
            \ 'n:declarations:1',
            \ 'f:functions:0',
            \ 'c:constructors:0'
        \ ],
        \ 'sro' : '.',
        \ 'kind2scope' : {
            \ 'd' : 'data',
            \ 'n' : 'newtype',
            \ 'c' : 'constructor',
            \ 't' : 'type'
        \ },
        \ 'scope2kind' : {
            \ 'data' : 'd',
            \ 'newtype' : 'n',
            \ 'constructor' : 'c',
            \ 'type' : 't'
        \ }
    \ }
endif
"}}}

"}}}

"""""""""""""""PLUG-INS""""""""""""""
" Rainbow parentheses TODO: Might delete{{{
"let g:rainbow_conf = {
"\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
"\	'ctermfgs': ['darkgray', 'darkblue', 'darkmagenta', 'darkcyan'],
"\	'operators': '_,_',
"\	'parentheses': [['(',')'], ['\[','\]'], ['{','}']],
"\	'separately': {
"\		'*': {},
"\		'lisp': {
"\			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
"\			'ctermfgs': ['darkgray', 'darkblue', 'darkmagenta', 'darkcyan', 'darkred', 'darkgreen'],
"\		},
"\		'vim': {
"\			'parentheses': [['fu\w* \s*.*)','endfu\w*'], ['for','endfor'], ['while', 'endwhile'], ['if','_elseif\|else_','endif'], ['(',')'], ['\[','\]'], ['{','}']],
"\		},
"\		'tex': {
"\			'parentheses': [['(',')'], ['\[','\]'], ['\\begin{.*}','\\end{.*}']],
"\		},
"\		'css': 0,
"\		'stylus': 0,
"\	}
"\}

nmap <leader>p :RainbowParentheses!! <CR>
""}}}

"Solarized{{{
syntax enable
set background=dark " dark|light "
colorscheme solarized
"}}}

"Powerline{{{
let g:airline_powerline_fonts = 1
"let g:Powerline_symbols="fancy"
"set guifont=Liberation\ Mono\ for\ Powerline\ 10
"powerline symbols
if !exists('g:airline_symbols')
let g:airline_symbols = {}
let &t_TI = ""
let &t_TE = ""
endif
"}}}

"Airline{{{

  " unicode symbols
  let g:airline_left_sep = '»'
  let g:airline_left_sep = '▶'
  let g:airline_right_sep = '«'
  let g:airline_right_sep = '◀'
  let g:airline_symbols.crypt = '🔒'
  let g:airline_symbols.linenr = '☰'
  let g:airline_symbols.linenr = '␊'
  let g:airline_symbols.linenr = '␤'
  let g:airline_symbols.linenr = '¶'
  let g:airline_symbols.maxlinenr = ''
  let g:airline_symbols.maxlinenr = '㏑'
  let g:airline_symbols.branch = '⎇'
  let g:airline_symbols.paste = 'ρ'
  let g:airline_symbols.paste = 'Þ'
  let g:airline_symbols.paste = '∥'
  let g:airline_symbols.spell = 'Ꞩ'
  let g:airline_symbols.notexists = 'Ɇ'
  let g:airline_symbols.whitespace = 'Ξ'

  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = '☰'
  let g:airline_symbols.maxlinenr = ''

  " old vim-powerline symbols
  let g:airline_left_sep = '⮀'
  let g:airline_left_alt_sep = '⮁'
  let g:airline_right_sep = '⮂'
  let g:airline_right_alt_sep = '⮃'
  let g:airline_symbols.branch = '⭠'
  let g:airline_symbols.readonly = '⭤'
  let g:airline_symbols.linenr = '⭡'
"}}}

"Tagbar{{{
nmap <F8> :TagbarToggle<CR>

command! -nargs=0 TagbarToggleStatusline call TagbarToggleStatusline()
function! TagbarToggleStatusline()
   let tStatusline = '%{exists(''*tagbar#currenttag'')?
            \tagbar#currenttag(''     [%s] '',''''):''''}'
   if stridx(&statusline, tStatusline) != -1
      let &statusline = substitute(&statusline, '\V'.tStatusline, '', '')
   else
      let &statusline = substitute(&statusline, '\ze%=%-', tStatusline, '')
   endif
endfunction
"}}}

"coc.nvim{{{
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
"}}}

"DiffW TODO: Not sure why I have this{{{
set diffopt+=iwhite
set diffexpr=DiffW()
function DiffW()
  let opt = ""
   if &diffopt =~ "icase"
     let opt = opt . "-i "
   endif
   if &diffopt =~ "iwhite"
     let opt = opt . "-w " " swapped vim's -b with -w
   endif
   silent execute "!diff -a --binary " . opt .
     \ v:fname_in . " " . v:fname_new .  " > " . v:fname_out
endfunction
"}}}

"Show function name in statusline {{{
function! ShortEcho(msg)
  " regular :echomsg is supposed to shorten long messages when shortmess+=T but it does not.
  " under "norm echomsg", echomsg does shorten long messages.
  let saved=&shortmess
  set shortmess+=T
  exe "norm :echomsg a:msg\n"
  let &shortmess=saved
endfunction

fun! ShowFuncName()
  let lnum = line(".")
  let col = col(".")
  echohl ModeMsg
  let ms = getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bWn'))
  call ShortEcho(ms)
  echohl None
endfun
"}}}

"let g:Tex_Env_equation = "\\begin{equation}\<CR><++>\<CR>\\end{equation}<++>"
"let g:jedi#auto_initialization = 0
"let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
"let g:ycm_autoclose_preview_window_after_completion = 1
"Toggle gundo
"nnoremap <leader>u :GundoToggle<CR>
"set undofile
"autocmd FileType python setlocal completeopt-=preview

"Fold this .vimrc
set modelines=1
" vim:foldmethod=marker:foldlevel=0
