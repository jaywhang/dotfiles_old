"""""""""""""""""""""""""""""""""""""""""
" Vundle Settings
"""""""""""""""""""""""""""""""""""""""""
set nocompatible

" It's faster to turn off 'filetype' while loading plugins, and turn it
" once we're ready to start editing.
filetype off

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#rc()

" Let Vundle manage Vundle (required)
Plugin 'gmarik/Vundle.vim'

" List of Bundles
Plugin 'kien/ctrlp.vim'
Plugin 'FelikZ/ctrlp-py-matcher'
Plugin 'flazz/vim-colorschemes'
Plugin 'tComment'
Plugin 'Raimondi/delimitMate'
Plugin 'tmhedberg/SimpylFold'
Plugin 'tpope/vim-fugitive'

" Work-related stuff
if filereadable(expand('~/.at_google.vim'))
  " Google-specific configurations
  source ~/.at_google.vim
else
  " Non-Google only
  Plugin 'google/maktaba'
  Plugin 'google/glaive'
  Plugin 'Valloric/YouCompleteMe'
  Plugin 'airblade/vim-gitgutter'
  Plugin 'scrooloose/syntastic'
endif


"""""""""""""""""""""""""""""""""""""""""
" Basic Settings
"""""""""""""""""""""""""""""""""""""""""
" Enable hidden buffers for effective buffer management.
set hidden

" Set the terminal title for vim.
set title

" Smoother changes.
set ttyfast

" Map <leader> to , (comma).
let mapleader = ","

" More powerful backspacing.
set backspace=indent,eol,start

" Show relative line numbers instead of absolute numbers.
set relativenumber

" Custom word separators.
set iskeyword-=_

" Show partial commands as you type.
set showcmd

" Keep longer history.
set history=1000

" Enable persistent undo.
set undodir=~/.vim/undo
set undofile

" Keep auto-backup and swap files in one location.
set backupdir=~/.vim/swp
set directory=~/.vim/swp

" More useful file/command completion.
set wildmenu
set wildmode=list:longest

" Set the default shell.
set shell=/bin/bash\ -l

" Highlight search terms.
set hlsearch
set incsearch  " Incrementally highlights as they are typed.

" Automatically figure out whether to use case sensitive or insensitive
" search.  'ignorecase' is required to use 'smartcase'.
set ignorecase
set smartcase

" More natural split opening
set splitbelow
set splitright

" Offer to reload file if it has been changed externally.
" Check this when any of the following happens:
"   - Enter a buffer, a window, or a tab
"   - Vim gains focus
"   - Start Insert mode
"   - Save the content of a buffer
"   - Don't move cursor for 750ms (in both normal and insert modes)
set updatetime=750
au BufEnter,BufWinEnter,WinEnter,FocusGained,InsertEnter * checktime
au BufWritePre,FileWritePre,CursorHold,CursorHoldI * checktime


"""""""""""""""""""""""""""""""""""""""""
" Scrolling Settings
"""""""""""""""""""""""""""""""""""""""""
" Disable line wrapping.
set nowrap

" Keep 3 lines at top/bottom when scrolling.
set scrolloff=3

" Keep 5 characters to the sides when side-scrolling.
set sidescrolloff=5

" Make side-scrolling smoother
set sidescroll=1

" Side-scrolling equivalent of C-U/C-D
map <C-L> z15l
map <C-H> z15h

" Make shift-insert work like in Xterm
if has('gui_running')
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>
endif


"""""""""""""""""""""""""""""""""""""""""
" Mouse Settings
"""""""""""""""""""""""""""""""""""""""""
set mouse=a
set ttymouse=xterm2
" Hide the mouse when typing text
set mousehide
" Toggle mouse with <F3>
" TODO


"""""""""""""""""""""""""""""""""""""""""
" Colors and Themes
"""""""""""""""""""""""""""""""""""""""""
" Enable 256 colors
set t_Co=256
let g:solarized_termcolors=256
let g:molokai_original=1

" Use dark terminal background.
set background=dark

" Default colorscheme.
colorscheme seoul256


"""""""""""""""""""""""""""""""""""""""""
" Coding & Syntax-related.
"""""""""""""""""""""""""""""""""""""""""
" Use syntax-based folding.
set foldmethod=syntax

" Create a visible column marker for 80 character limit.
set colorcolumn=80
" Highlight characters exceeding the 80 character limit in a line.
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%>80v.\+/

" Indentation (soft tabs, each with 4 spaces).
set autoindent
set expandtab
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Show matching braces.
set sm

" Force all *.md files to be read as Markdown, instead of Modula-2.
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Display error for trailing whitespace
match ErrorMsg '\s\+$'


"""""""""""""""""""""""""""""""""""""""""
" Status Bar Settings
"""""""""""""""""""""""""""""""""""""""""
" Always display the status bar.
set laststatus=2

set statusline+=%F      " Filepath relative to CWD, limited to 30 chars
set statusline+=\ [%{strlen(&fenc)?&fenc:'none'},  " Show file encoding
set statusline+=%{&ff}] " File format
set statusline+=%h      " Help file flag
set statusline+=%m      " Modified flag
set statusline+=%r      " Read-only flag
set statusline+=%y      " Filetype
" set statusline+=\ \ %#warningmsg#              " Syntastic warning msg
" set statusline+=%{SyntasticStatuslineFlag()}   " Syntastic warning msg
" set statusline+=%*                             " Syntastic warning msg
set statusline+=%=      " Left/right separator
set statusline+=%l,%c   " Line number, cursor column
set statusline+=\ \ \ \ %p%%  " Percent through file


"""""""""""""""""""""""""""""""""""""""""
" Custom Key Mappings 
"""""""""""""""""""""""""""""""""""""""""
" Tab control
nnoremap th  :tabprev<CR>
nnoremap tl  :tabnext<CR>
nnoremap te  :tabedit<Space>
nnoremap tt  :tabedit<CR>
nnoremap td  :tabclose<CR>
nnoremap tm  <C-w><S-T>  " Move current buffer to a new tab

" Make 'goto file' open the target file in new tab by default.
nnoremap gf <C-w>gf

" Sort current paragraph block (sb for 'Sort Block').
nnoremap sb vip:sort<CR>

" Run CtrlP in CWD.
nnoremap <Leader>p :CtrlPCurWD<CR>
" Clear CtrlP cache.
nnoremap <Leader>cc :CtrlPClearAllCaches<CR>

" Temporarily switching off search highlight.
nmap <silent> <leader>n :silent :nohlsearch<CR>

" Catch trailing whitespace.
set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>s :set nolist!<CR>

" Remove all trailing whitespaces with the hotkey '<Leader>rtw'.
nnoremap <Leader>rtw :%s/\s\+$//e<CR>

" Map space to toggle fold.
nnoremap <Space> za

" Toggle comment (uses tComment key mapping).
nmap ,, <c-_><c-_>

" Toggle between paste mode and normal mode with <F9>.
set pastetoggle=<F9>


"""""""""""""""""""""""""""""""""""""""""
" CtrlP Settings
"""""""""""""""""""""""""""""""""""""""""
" Use CtrlPMixed mode by default.
let g:ctrlp_cmd = 'CtrlPMixed'

" Limit CtrlP search.
let g:ctrlp_max_files=10000
let g:ctrlp_max_depth=15

" Set delay to prevent extra search.
let g:ctrlp_lazy_update = 200

" Include current folder + nearest source control project folder (that contains
" e.g. .git, .hg, .svn, .bzr, _darcs).
let g:ctrlp_working_path_mode = 'ra'

" Speed up indexing (from http://blog.patspam.com/2014/super-fast-ctrlp).
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ --ignore .git5_specs
      \ -g ""'

" Make CtrlP use pymatcher for faster matching.
if !has('python')
  echo 'In order to use pymatcher plugin, you need +python compiled vim'
else
  let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
endif

" Use cache for faster lookups.
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 1

" Keep match window small and include 100 results (i.e., enable scroll).
let g:ctrlp_match_window = 'results:100'


"""""""""""""""""""""""""""""""""""""""""
" YouCompleteMe Settings
"""""""""""""""""""""""""""""""""""""""""
" Comments and strings are fair game for autocompletion.
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_comments_and_strings = 1

" Start autocompleting right away, after a single character.
let g:ycm_min_num_of_chars_for_completion = 1

" This provides nice autocompletion for C++ #include's if I change vim's working
" directory to the project root.
let g:ycm_filepath_completion_use_working_dir = 1

" Add programming language keywords to the autocomplete list.
let g:ycm_seed_identifiers_with_syntax = 1

" Disable diagnostics UI.
let g:ycm_show_diagnostics_ui = 0

" Log more verbosely.
let g:ycm_server_log_level = 'debug'


"""""""""""""""""""""""""""""""""""""""""
" Syntastic Settings
"""""""""""""""""""""""""""""""""""""""""
let g:syntastic_check_on_open = 1
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'


"""""""""""""""""""""""""""""""""""""""""
" GitGutter Settings
"""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '➜'
let g:gitgutter_sign_removed = '✘'
let g:gitgutter_realtime = 1
let g:gitgutter_max_signs = 1500
let g:gitgutter_sign_removed_first_line = '^^'
let g:gitgutter_sign_modified_removed = 'ww'


"""""""""""""""""""""""""""""""""""""""""
" ....Are we done?
"""""""""""""""""""""""""""""""""""""""""
" Turn filetype back on.
filetype plugin indent on
syntax on