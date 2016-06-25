" vim: set foldmethod=marker foldlevel=0:
" VIM-PLUG BLOCK {{{
" ============================================================================

call plug#begin('~/.vim/plugged')

" Airline for statusbar
Plug 'vim-airline/vim-airline'

" Autocomplete
Plug 'Shougo/neocomplete.vim'

" Fix folding speed
Plug 'Konfekt/FastFold'

" git in Vim
Plug 'airblade/vim-gitgutter'

" Surround
Plug 'tpope/vim-surround'

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
Plug 'pangloss/vim-javascript'
Plug 'othree/yajs'
Plug 'mxw/vim-jsx'
Plug 'heavenshell/vim-jsdoc'
Plug 'JulesWang/css.vim'
Plug 'honza/dockerfile.vim'
Plug 'plasticboy/vim-markdown'
Plug 'groenewege/vim-less'
Plug 'joukevandermaas/vim-ember-hbs'

" Clojure
Plug 'tpope/vim-classpath'
Plug 'guns/vim-clojure-static'
Plug 'kien/rainbow_parentheses.vim'
" Plug 'guns/vim-sexp'
" Plug 'tpope/vim-sexp-mappings-for-regular-people'
" Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-salve'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-dispatch'

" Purescript
Plug 'FrigoEU/psc-ide-vim'
Plug 'raichoo/purescript-vim'

" tmux stuff
Plug 'edkolev/tmuxline.vim'
Plug 'tpope/vim-tbone'

" Themes
Plug 'flazz/vim-colorschemes'

" Add plugins to &runtimepath
call plug#end()

" }}}
" ============================================================================
" BASIC SETTINGS {{{
" ============================================================================

" colorscheme Tomorrow-Night
" set t_ut=
" set t_Co=256   " This is may or may not needed.

set background=dark
colorscheme gruvbox

filetype plugin indent on          " Load plugins according to detected filetype.
syntax on                          " Enable syntax highlighting.

set autoindent                     " Indent according to previous line.
set expandtab                      " Use spaces instead of tabs.
set softtabstop =2                 " Tab key indents by 2 spaces.
set shiftwidth  =2                 " >> indents by 2 spaces.
set shiftround                     " >> indents to next multiple of 'shiftwidth'.

set backspace   =indent,eol,start  " Make backspace work as you would expect.
set hidden                         " Switch between buffers without having to save first.
set laststatus  =2                 " Always show statusline.
set display     =lastline          " Show as much as possible of the last line.

set showmode                       " Show current mode in command-line.
set showcmd                        " Show already typed keys when more are expected.

set incsearch                      " Highlight while searching with / or ?.
set hlsearch                       " Keep matches highlighted.

set ttyfast                        " Faster redrawing.
set lazyredraw                     " Only redraw when necessary.

set splitbelow                     " Open new windows below the current window.
set splitright                     " Open new windows right of the current window.

set cursorline                     " Find the current line quickly.
set wrapscan                       " Searches wrap around end-of-file.
set report      =0                 " Always report changed lines.
set synmaxcol   =200               " Only highlight the first 200 columns.
set number                         " Yeah line numbers
set timeoutlen=1000                " Remove delay when changing modes
set ttimeoutlen=0

set list                           " Show non-printable characters.
if has('multi_byte') && &encoding ==# 'utf-8'
  let &listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±'
else
  let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
endif

" Annoying temporary files
set backupdir=/tmp//,.
set directory=/tmp//,
set noswapfile

" Stores undo state even when files are closed (in undodir)
set undodir=$HOME/.vim/undo
set undofile


" }}}
" ============================================================================
" MAPPINGS {{{
" ============================================================================

" ----------------------------------------------------------------------------
" Basic mappings
" ----------------------------------------------------------------------------

let mapleader = "\<Space>"

" sd escaping
inoremap sd <Esc>
xnoremap sd <Esc>
cnoremap sd <C-c>

" <F10> | NERD Tree
inoremap <F10> <esc>:NERDTreeToggle<cr>
nnoremap <F10> :NERDTreeToggle<cr>

" Fast saving
nmap <leader>w :w!<cr>

" Set paste
map <leader>pp :setlocal paste!<cr>

" Remap VIM 0 to first non-blank character
map 0 ^

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

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Move up and down on physical lines
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

"Purescript
"let g:psc_ide_log_level = 3
au FileType purescript nmap <leader>t :PSCIDEtype<CR>
au FileType purescript nmap <leader>s :PSCIDEapplySuggestion<CR>
au FileType purescript nmap <leader>r :PSCIDEload<CR>
au FileType purescript nmap <leader>p :PSCIDEpursuit<CR>
au FileType purescript nmap <leader>c :PSCIDEcaseSplit<CR>
au FileType purescript nmap <leader>a :PSCIDEaddTypeAnnotation<CR>
au FileType purescript nmap <leader>i :PSCIDEimportIdentifier<CR>
au FileType purescript nmap <leader>qd :PSCIDEremoveImportQualifications<CR>
au FileType purescript nmap <leader>qa :PSCIDEaddImportQualifications<CR>
nmap <leader>g <C-]>

au FileType purescript nmap <leader>fm :set foldmethod=manual<CR>zE<CR>
au FileType purescript nmap <leader>fe :set foldmethod=expr<CR>
au FileType purescript set foldexpr=PureScriptFoldLevel(v:lnum)

au FileType purescript set conceallevel=1
au FileType purescript set concealcursor=nvc
au FileType purescript syn keyword purescriptForall forall conceal cchar=∀

function! PureScriptFoldLevel(l)
  return getline(a:l) =~ "^\d*import"
endfunction

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
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" CtrlP options
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = '\v[\/](node_modules|bower_components|target|dist|compiled|coverage|output)|(\.(swp|ico|git|svn))$'

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

  au VimEnter * RainbowParenthesesToggle
  au Syntax * RainbowParenthesesLoadRound
  au Syntax * RainbowParenthesesLoadSquare
  au Syntax * RainbowParenthesesLoadBraces

  " Remove auto-comments
  au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
  au FileType purescript PSCIDEstart


augroup END
