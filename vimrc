" TODO still improving
" neovim is recommanded
" settings are based on or highly inspired by:
" * https://gist.github.com/subfuzion/7d00a6c919eeffaf6d3dbf9a4eb11d64

set nocompatible              " be iMproved, required

" bash like tab completion
set wildmode=longest,list,full
set wildmenu

if has('nvim')
  if has('unix')
    let _plug_path='~/.local/share/nvim/plugged'
  elseif has('win32')
    let _plug_path='~\AppData\Local\nvim\autoload\plug.vim'
  endif
else
  if has('unix')
    let _plug_path='~/.vim/plugged'
  elseif has('win32')
    let _plug_path='~\vimfiles\plugged'
  endif
endif

call plug#begin(_plug_path)

" color theme
Plug 'ajh17/Spacegray.vim'

" color theme soloarized
Plug 'ericbn/vim-solarized'

" vim formatter wrapper plugin
Plug 'Chiel92/vim-autoformat'

" (loaded on first invocation of the command)
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" nerdtree-git-plugin - show git status in NERD Tree
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'kien/ctrlp.vim'

" [Python] correct folding
Plug 'tmhedberg/SimpylFold'

" Fuzzy searching and autocompleting
" hot key triggerred
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'

" .editorconfig support
Plug 'editorconfig/editorconfig-vim'

" [Go] basic usage plugin
Plug 'fatih/vim-go'

if has('nvim')
  " [Go] easy debugging
  Plug 'jodosha/vim-godebug'
 
  " https://github.com/nsf/gocode
  Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.local/share/nvim/plugged/gocode/nvim/symlink.sh' }
  
  " deoplete (for gocode completion support)
  " https://github.com/Shougo/deoplete.nvim
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  
  " deoplete-go (for gocode completion support)
  " https://github.com/zchee/deoplete-go
  Plug 'zchee/deoplete-go', { 'do': 'make'}
endif

call plug#end()            " required

" Auto start NERD tree when opening a directory
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | wincmd p | endif

" Auto start NERD tree if no files are specified
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | exe 'NERDTree' | endif

" Let quit work as expected if after entering :q the only window left open is NERD Tree itself
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" default 2 space tab
set smartindent
set expandtab
set tabstop=2

" default encoding
set encoding=utf-8

" highlight matches when searching
" Use C-l to clear (see key map section)
set hlsearch

" Line numbering
" Toggle set to ';n' in key map section
set nu

" Disable line wrapping
" Toggle set to ';w' in key map section
set nowrap

" enable line and column display
set ruler

" fileetype recognition
filetype on
filetype plugin on
filetype indent on

" syntax highlighting
syntax on

" scroll a bit horizontally when at the end of the line
set sidescroll=6

" Make it easier to work with buffers
" http://vim.wikia.com/wiki/Easier_buffer_switching
set hidden
set confirm
set autowriteall
set wildmenu wildmode=full

" open new split panes to right and below (as you probably expect)
set splitright
set splitbelow

colorscheme spacegray
" syntax enable
" set background=light
" colorscheme solarized
"set termguicolors

" TODO comment these global settings
let g:SimpyFold_docstring_preview=1

let python_highlight_all=1

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

set clipboard=unnamed

let g:ycm_python_binary_path = 'python'

" =====================================
" auto completion
" =====================================
set completeopt+=noinsert
set completeopt+=noselect
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#use_cache = 1
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']


" change the leader key from "\" to ";" ("," is also popular)
let mapleader=";"

" Shortcut to edit THIS configuration file: (e)dit (c)onfiguration
nnoremap <silent> <leader>ec :e $MYVIMRC<CR>

" Shortcut to source (reload) THIS configuration file after editing it: (s)ource (c)onfiguraiton
nnoremap <silent> <leader>sc :source $MYVIMRC<CR>

" use ;; for escape
" http://vim.wikia.com/wiki/Avoid_the_escape_key
inoremap ;; <Esc>

" Toggle NERDTree
" Can't get <C-Space> by itself to work, so this works as Ctrl - space - space
" https://github.com/neovim/neovim/issues/3101
" http://stackoverflow.com/questions/7722177/how-do-i-map-ctrl-x-ctrl-o-to-ctrl-space-in-terminal-vim#answer-24550772
"nnoremap <C-Space> :NERDTreeToggle<CR>
"nmap <C-@> <C-Space>
nnoremap <silent> <Space> :NERDTreeToggle<CR>

" toggle tagbar
nnoremap <silent> <leader>tb :TagbarToggle<CR>

" toggle line numbers
nnoremap <silent> <leader>n :set number! number?<CR>

" toggle line wrap
nnoremap <silent> <leader>w :set wrap! wrap?<CR>

" toggle buffer (switch between current and last buffer)
nnoremap <silent> <leader>bb <C-^>

" go to next buffer
nnoremap <silent> <leader>bn :bn<CR>
nnoremap <C-l> :bn<CR>

" go to previous buffer
nnoremap <silent> <leader>bp :bp<CR>
" https://github.com/neovim/neovim/issues/2048
nnoremap <C-h> :bp<CR>

" close buffer
nnoremap <silent> <leader>bd :bd<CR>
noremap <C-n> :NERDTreeToggle<CR>

" kill buffer
nnoremap <silent> <leader>bk :bd!<CR>

" list buffers
nnoremap <silent> <leader>bl :ls<CR>
" list and select buffer
nnoremap <silent> <leader>bg :ls<CR>:buffer<Space>

" horizontal split with new buffer
nnoremap <silent> <leader>bh :new<CR>

" vertical split with new buffer
nnoremap <silent> <leader>bv :vnew<CR>

" redraw screan and clear search highlighted items
"http://stackoverflow.com/questions/657447/vim-clear-last-search-highlighting#answer-25569434
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

" for autoformat
noremap <C-f> :Autoformat<CR>

" Mapping selecting mappings
nnoremap <leader><tab> <plug>(fzf-maps-n)
noremap <leader><tab> <plug>(fzf-maps-x)
onoremap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
inoremap <c-x><c-k> <plug>(fzf-complete-word)
inoremap <c-x><c-f> <plug>(fzf-complete-path)
inoremap <c-x><c-j> <plug>(fzf-complete-file-ag)
inoremap <c-x><c-l> <plug>(fzf-complete-line)

" improved keyboard navigation
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

if has('nvim')
  " improved keyboard support for navigation (especially terminal)
  " https://neovim.io/doc/user/nvim_terminal_emulator.html
  tnoremap <Esc> <C-\><C-n>
  tnoremap <A-h> <C-\><C-n><C-w>h
  tnoremap <A-j> <C-\><C-n><C-w>j
  tnoremap <A-k> <C-\><C-n><C-w>k
  tnoremap <A-l> <C-\><C-n><C-w>l
endif
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
nnoremap <silent> <leader>tt :terminal<CR>
nnoremap <silent> <leader>tv :vnew<CR>:terminal<CR>
nnoremap <silent> <leader>th :new<CR>:terminal<CR>
tnoremap <C-x> <C-\><C-n><C-w>q

" ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = ''

" toggle colors to optimize based on light or dark background
nnoremap <leader>c :call ToggleLightDark()<CR>

" =====================================
" Go
" https://github.com/fatih/vim-go
" =====================================
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" go-def is automatically by default to plain "gd" (no leader required)
au FileType go nnoremap <Leader>gd <Plug>(go-def)
au FileType go nmap <Leader>gp <Plug>(go-def-pop)

au FileType go nnoremap <Leader>gv <Plug>(go-doc-vertical)
" or open in a browser...
au FileType go nnoremap <Leader>gb <Plug>(go-doc-browser)

au FileType go nnoremap <Leader>s <Plug>(go-implements)
au FileType go nnoremap <Leader>i <Plug>(go-info)
au FileType go nnoremap <Leader>gl <Plug>(go-metalinter)
au FileType go nnoremap <Leader>gc <Plug>(go-callers)

