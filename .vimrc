set nocompatible    " use vim defaults
filetype off

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

" information line bar
Plugin 'bling/vim-airline'

" to call git commands inside vim
Plugin 'tpope/vim-fugitive'

" NerdTree
Plugin 'scrooloose/nerdtree'
map <F2> :NERDTreeToggle<CR>

"Python mode
Plugin 'klen/python-mode'

" Jedi Vim - Autcompletion
Plugin 'davidhalter/jedi-vim'

" Color scheme
set t_Co=256 " to use 256 colours
Plugin 'tomasr/molokai'

" All pPlugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


" The rest of your config follows here

let mapleader = " "
" show line number
set number
" visual autocomplete for command menu
set wildmenu
" redraw only when vim needs to
set lazyredraw
" let g:molokai_original = 1
colorscheme molokai

syntax on                 " syntax highlighing

set tags=tags;$HOME/.vim/tags/ "recursively searches directory for 'tags' file

set expandtab       " tabs are converted to space
"set softtabstop=4
set tabstop=4       " numbers of spaces of tab character
set shiftwidth=4    " numbers of spaces to (auto)indent
"set shiftround

" mapping escape key
inoremap jk <Esc>
" mapping command key
nmap ; :

set showcmd         " display incomplete commands
set hlsearch        " highlight searches
set incsearch       " do incremental searching
set ruler           " show the cursor position all the time
set numberwidth=4   " line numbering takes up 5 spaces
set ignorecase      " ignore case when searching
set nowrap          " stop lines from wrapping
set mouse=a         " enable mouse


" reload .vimrc
nnoremap <LEADER>rv :source $MYVIMRC<CR>
" moving block of codes more easily
vnoremap < <gv
vnoremap > >gv

" get matching brackets
"inoremap {      {}<Left>
"inoremap {<CR>  {<CR>}<Esc>O
"inoremap {{     {
"inoremap {}     {}
"inoremap (      ()<Left>
"inoremap (<CR>  (<CR>}<Esc>O
"inoremap ((     (
"inoremap ()     ()
"inoremap [      []<Left>
"inoremap [<CR>  [<CR>]<Esc>O
"inoremap [[     [
"inoremap []     []

set cursorline      " show a visual line under the cursor's current line 

set showmatch       " show the matching part of the pair for [] {} and ()
" How many tenths of a second to blink when matching brackets
set mat=2

" moving betwen windows
map <C-j> <C-W>j<C-W>_
map <C-k> <C-W>k<C-W>_
map <C-l> <C-W>l<C-W>_
map <C-h> <C-W>h<C-W>_

" Python-mode
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

" Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 1 
map f za
map F zA

let g:pymode_trim_whitespaces = 1

let g:pymode_rope = 0 " desiable autocompletion to use jedi-vim
let g:pymode_motion = 1  " jump to class or function

augroup vimrc_autocmds
    autocmd!
    " highlight characters past column 120
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python match Excess /\%120v.*/
    autocmd FileType python set nowrap
    augroup END
