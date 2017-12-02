"""""""""""""""""""""""""""""""""""""""""
" Vundle Settings
"""""""""""""""""""""""""""""""""""""""""
set nocompatible

" It's faster to turn off 'filetype' while loading plugins, and turn it
" once we're ready to start editing.
filetype off

" Extract hostname for machine-dependent config.
let hostname = substitute(system('hostname'), '\n', '', '')

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
Plugin 'lervag/vimtex'
Plugin 'junegunn/seoul256.vim'
Plugin 'google/vim-searchindex'
Plugin 'bkad/CamelCaseMotion'
Plugin 'airblade/vim-gitgutter'

" Work-related stuff
if filereadable(expand('~/.at_google.vim'))
  " Google-specific configurations
  source ~/.at_google.vim
else
  " Non-Google only
  Plugin 'google/maktaba'
  Plugin 'google/glaive'
  Plugin 'scrooloose/syntastic'

  " Exclude Raspberry Pi (Rothko).
  if hostname != 'rothko'
    Plugin 'Valloric/YouCompleteMe'
  endif
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
" ... but still show the absolute line number for the current line.
set number

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

" More natural split opening.
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

" Use system clipboard for copying.  Requires vim version >= 7.3.74
" For some reason, different setting is required for OS X.
if has('mac')
  set clipboard+=unnamed
elseif !has('mac')
  set clipboard^=unnamedplus
endif


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

" Needed for better color support inside tmux.
" More info: https://github.com/lifepillar/vim-solarized8/issues/1
set t_8f=[38;2;%lu;%lu;%lum
set t_8b=[48;2;%lu;%lu;%lum

" Use dark terminal background.
set background=dark

"	When on, uses |highlight-guifg| and |highlight-guibg| attributes in the
"	terminal, thus enabling 24-bit color.
set termguicolors

" Default colorschemes.
if has('mac')
  colorscheme seoul256
elseif has('unix')
  colorscheme darkocean
endif


"""""""""""""""""""""""""""""""""""""""""
" Coding & Syntax-related.
"""""""""""""""""""""""""""""""""""""""""
" Use syntax-based folding.
set foldmethod=syntax

" Highlight characters exceeding the 80 character limit in a line.
augroup vimrc_autocmds
  autocmd BufEnter,WinEnter * highlight OverLength ctermbg=darkgray ctermfg=white guibg=#FFD9D9
  autocmd BufEnter,WinEnter * match OverLength /\%>80v.\+/
augroup END

" Create a visible column marker for 80 character limit.
" set colorcolumn=80

" Indentation (soft tabs, each with 2 spaces).
set noexpandtab " Make sure that every file uses real tabs, not spaces
set expandtab   " Use spaces instead of real tabs
set shiftround  " Round indent to multiple of 'shiftwidth'
set smartindent " Do smart indenting when starting a new line
set autoindent  " Copy indent from current line, over to the new line
set tabstop=2
set shiftwidth=2
set softtabstop=2

" Show matching braces.
set sm

" Force all *.md files to be read as Markdown, instead of Modula-2.
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Display error for trailing whitespace
match ErrorMsg '\s\+$'


"""""""""""""""""""""""""""""""""""""""""
" LaTeX Settings
"""""""""""""""""""""""""""""""""""""""""
" Better filetype matching.
let g:tex_flavor = 'latex'

" Prevents vimtex from complaining about unset servername
let g:vimtex_compiler_latexmk = {'callback' : 0}

" Autocomplete support with YouCompleteMe.
if !exists('g:ycm_semantic_triggers')
	let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = [
			\ 're!\\[A-Za-z]*(ref|cite)[A-Za-z]*([^]]*])?{([^}]*,?)*',
			\ 're!\\includegraphics([^]]*])?{[^}]*',
			\ 're!\\(include|input){[^}]*',
      \ '{'
			\ ]

""" vimtex configurations
let g:vimtex_fold_enabled = 1
" Without this, folding is really slow.
let g:vimtex_fold_manual = 1
let g:vimtex_indent_enabled = 1

" Set default PDF viewer
if has('mac')
  let g:vimtex_view_general_viewer
    \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
    let g:vimtex_view_general_options = '-r @line @pdf @tex'

  " This adds a callback hook that updates Skim after compilation
  let g:vimtex_latexmk_callback_hooks = ['UpdateSkim']
  function! UpdateSkim(status)
    if !a:status | return | endif

    let l:out = b:vimtex.out()
    let l:tex = expand('%:p')
    let l:cmd = [g:vimtex_view_general_viewer, '-r']
    if !empty(system('pgrep Skim'))
      call extend(l:cmd, ['-g'])
    endif
    if has('nvim')
      call jobstart(l:cmd + [line('.'), l:out, l:tex])
    elseif has('job')
      call job_start(l:cmd + [line('.'), l:out, l:tex])
    else
      call system(join(l:cmd + [line('.'), shellescape(l:out), shellescape(l:tex)], ' '))
    endif
  endfunction
elseif has('unix')
  let g:vimtex_view_method = 'general'
  let g:vimtex_view_general_viewer = 'evince'
endif

" Auto save for tex files
autocmd CursorHold,CursorHoldI *.tex update

" Clean up auxiliary files upon exiting
autocmd VimLeave *.tex :lcd %:p:h | !latexmk -c


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
set statusline+=\ \ %#warningmsg#              " Syntastic warning msg
set statusline+=%{SyntasticStatuslineFlag()}   " Syntastic warning msg
set statusline+=%*                             " Syntastic warning msg
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
nnoremap tH  :tabm -1<CR>
nnoremap tL  :tabm +1<CR>

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

" Search for visually selected text.
vnoremap // y/<C-R>"<CR>

" Vertically center cursor when searching.
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz


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
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'


"""""""""""""""""""""""""""""""""""""""""
" Syntastic Settings
"""""""""""""""""""""""""""""""""""""""""
let g:syntastic_check_on_open = 1
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'
let g:syntastic_python_checkers = ['python']


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
" CamelCaseMotion Settings
"""""""""""""""""""""""""""""""""""""""""
" call camelcasemotion#CreateMotionMappings('<leader>')
" map <silent> w <Plug>CamelCaseMotion_w
" map <silent> b <Plug>CamelCaseMotion_b
" map <silent> e <Plug>CamelCaseMotion_e
" map <silent> ge <Plug>CamelCaseMotion_ge
" sunmap w
" sunmap b
" sunmap e
" sunmap ge

"""""""""""""""""""""""""""""""""""""""""
" ....Are we done?
"""""""""""""""""""""""""""""""""""""""""

" Turn filetype back on.
filetype plugin indent on
syntax on
