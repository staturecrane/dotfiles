" vim: set foldmethod=marker foldlevel=0:
" VIM-PLUG BLOCK {{{
" ============================================================================

call plug#begin('~/.vim/plugged')

" Autocomplete
Plug 'Shougo/neocomplete.vim'

" File explorer
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" git in Vim
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Surround
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

" Heuristically set buffer options
Plug 'tpope/vim-sleuth'

" Tabularize
Plug 'godlygeek/tabular'

" EasyMotion -- jump to words
Plug 'Lokaltog/vim-easymotion'

" Comments
Plug 'tpope/vim-commentary'

" Fuzzy finder
Plug 'kien/ctrlp.vim'

" Match everything with %
Plug 'edsono/vim-matchit'

" Syntax checking
Plug 'scrooloose/syntastic'

" Langauge-related plugins
Plug 'heavenshell/vim-jsdoc'
Plug 'pangloss/vim-javascript'
Plug 'othree/yajs.vim'
Plug 'mxw/vim-jsx'
Plug 'hail2u/vim-css3-syntax'
Plug 'gkz/vim-ls'
Plug 'honza/dockerfile.vim'
Plug 'plasticboy/vim-markdown'

" tmux status integration
Plug 'edkolev/tmuxline.vim'

" tmux pane/window support
Plug 'tpope/vim-tbone'

" Themes
Plug 'sickill/vim-monokai'
Plug 'tomasr/molokai'
Plug 'jnurmine/Zenburn'

" Add plugins to &runtimepath
call plug#end()

" }}}
" ============================================================================
" BASIC SETTINGS {{{
" ============================================================================

colorscheme monokai
set t_ut=

syntax enable
filetype plugin on
filetype indent on

set nu
set autoindent
set smartindent
set lazyredraw
set laststatus=2
set showcmd
set visualbell
set backspace=indent,eol,start
set timeoutlen=500
set whichwrap=b,s
set shortmess=aIT
set hlsearch " CTRL-L / CTRL-R W
set incsearch
set hidden
set ignorecase smartcase
set wildmenu
set wildmode=full
set expandtab smarttab
set scrolloff=5
set encoding=utf-8
set list
set listchars=tab:\|\ ,
set virtualedit=block
set nojoinspaces
set diffopt=filler,vertical
set autoread
set clipboard=unnamed
set foldlevelstart=99
set grepformat=%f:%l:%c:%m,%f:%l:%m
set completeopt=menuone,preview,longest
set nocursorline

" Annoying temporary files
set backupdir=/tmp//,.
set directory=/tmp//,

" Stores undo state even when files are closed (in undodir)
set undodir=$HOME/.vim/undo
set undofile

" GitGutter tmp fix
set shell=/bin/bash

" }}}
" ============================================================================
" MAPPINGS {{{
" ============================================================================

" ----------------------------------------------------------------------------
" Basic mappings
" ----------------------------------------------------------------------------

" kj escaping
inoremap kj <Esc>
xnoremap kj <Esc>
cnoremap kj <C-c>

" <F10> | NERD Tree
inoremap <F10> <esc>:NERDTreeToggle<cr>
nnoremap <F10> :NERDTreeToggle<cr>

" Fast saving
nmap <leader>w :w!<cr>

" Set paste
map <leader>pp :setlocal paste!<cr>

" Remap VIM 0 to first non-blank character
map 0 ^

" Disable CTRL-A on tmux or on screen
if $TERM =~ 'screen'
  nnoremap <C-a> <nop>
  nnoremap <Leader><C-a> <C-a>
endif

" No Ex mode (see :help Q)
nnoremap Q <nop>

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext<cr>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" }}}
" ============================================================================
" FUNCTIONS {{{
" ----------------------------------------------------------------------------
" Todo
" ----------------------------------------------------------------------------
function! s:todo() abort
  let entries = []
  for cmd in ['git grep -n -e TODO -e FIXME -e XXX 2> /dev/null',
            \ 'grep -rn -e TODO -e FIXME -e XXX * 2> /dev/null']
    let lines = split(system(cmd), '\n')
    if v:shell_error != 0 | continue | endif
    for line in lines
      let [fname, lno, text] = matchlist(line, '^\([^:]*\):\([^:]*\):\(.*\)')[1:3]
      call add(entries, { 'filename': fname, 'lnum': lno, 'text': text })
    endfor
    break
  endfor

  if !empty(entries)
    call setqflist(entries)
    copen
  endif
endfunction
command! Todo call s:todo()

" }}}
" ============================================================================
" PLUGINS {{{
" ============================================================================

" Syntastic settings
let g:syntastic_javascript_checkers = ['eslint']

" CtrlP options
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist|compiled|coverage)|(\.(swp|ico|git|svn))$'

" ----------------------------------------------------------------------------
" <leader>t | vim-tbone
" ----------------------------------------------------------------------------
function! s:tmux_send(dest) range
  call inputsave()
  let dest = empty(a:dest) ? input('To which pane? ') : a:dest
  call inputrestore()
  silent call tbone#write_command(0, a:firstline, a:lastline, 1, dest)
endfunction
for m in ['n', 'x']
  let gv = m == 'x' ? 'gv' : ''
  execute m."noremap <silent> <leader>tt :call <SID>tmux_send('')<cr>".gv
  execute m."noremap <silent> <leader>th :call <SID>tmux_send('.left')<cr>".gv
  execute m."noremap <silent> <leader>tj :call <SID>tmux_send('.bottom')<cr>".gv
  execute m."noremap <silent> <leader>tk :call <SID>tmux_send('.top')<cr>".gv
  execute m."noremap <silent> <leader>tl :call <SID>tmux_send('.right')<cr>".gv
  execute m."noremap <silent> <leader>ty :call <SID>tmux_send('.top-left')<cr>".gv
  execute m."noremap <silent> <leader>to :call <SID>tmux_send('.top-right')<cr>".gv
  execute m."noremap <silent> <leader>tn :call <SID>tmux_send('.bottom-left')<cr>".gv
  execute m."noremap <silent> <leader>t. :call <SID>tmux_send('.bottom-right')<cr>".gv
endfor

" ----------------------------------------------------------------------------
" neocomplete
" ----------------------------------------------------------------------------

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

" }}}
" ============================================================================
" AUTOCMD {{{
" ============================================================================

augroup vimrc
  autocmd!

  " File types
  au BufNewFile,BufRead Dockerfile* set filetype=dockerfile

  " http://vim.wikia.com/wiki/Highlight_unwanted_spaces
  au BufNewFile,BufRead,InsertLeave * silent! match ExtraWhitespace /\s\+$/
  au InsertEnter * silent! match ExtraWhitespace /\s\+\%#\@<!$/

  " Unset paste on InsertLeave
  au InsertLeave * silent! set nopaste

  " Automatic rename of tmux window
  if exists('$TMUX') && !exists('$NORENAME')
    au BufEnter * call system('tmux rename-window '.expand('%:t:S'))
    au VimLeave * call system('tmux set-window automatic-rename on')
  endif

  " Return to last edit position when opening files (You want this!)
  au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \ exe "normal! g`\"" |
        \ endif

  " Delete trailing white space on save
  au BufRead,BufWritePre,FileWritePre * silent! %s/[\r \t]\+$//

augroup END
