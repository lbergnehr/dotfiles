" This is Leo Bergnéhr's .vimrc.
" Use whatever you want for your own.

" ==============================================================================
" *Package manager (Vundle)*
" ==============================================================================
  " Make sure vundle exists in this path
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#rc()

  " Let Vundle manage Vundle (required)!
  Bundle 'gmarik/vundle'

  " === Plugins ===
  " Essential
  Bundle 'Solarized'
  Bundle 'fugitive.vim'
  Bundle 'mattn/emmet-vim'

  " Good to have
  Bundle 'surround.vim'
  Bundle "pangloss/vim-javascript"
  Bundle 'loremipsum'
  Bundle 'abolish.vim'
  Bundle 'vim-stylus'
  Bundle 'bling/vim-airline'

" ==============================================================================
" *Mappings*
" ==============================================================================
" Remap leader to ','
let mapleader = ","
let g:mapleader = ","

" Map jk to Escape (beats jj any time of day ;))
imap jk <esc>
" Make tab jump between matching brackets
nnoremap <tab> %
vnoremap <tab> %
" Change the meaning of ' and ` since ` is easier to reach and used more often
nnoremap ' `
vnoremap ' `
nnoremap ` '
vnoremap ` '
" Disable highlight when <cr> is pressed
map <silent> <cr> :noh<cr>
" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>
" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" === Spelling ===
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>
" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

filetype indent on
filetype plugin on
set omnifunc=syntaxcomplete#Complete

map <leader><C-h> :tabprevious<cr>
map <leader><C-l> :tabnext<cr>

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Nauman
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" === Moving / navigating ===
" Treat visual lines as break lines which is more sane to me
map j gj
map k gk
map 0 g0
map $ g$
" Remap VIM 0 to first non-blank character
map 0 ^
" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" === Buffers / windows / tabs ===
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
" Quicky open a new window and switch over to it
nnoremap <leader>w <C-w>v<C-w>l

" Automatically close a opening bracket followed by return
inoremap {<cr> {<cr>}<esc>O

" Change between current and secondary files
map <leader><leader> <C-^>

" Shortcut to dir of current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

" Insert a hash rocket with <c-l>
imap <c-l> <space>=><space>

" Map cnext/cprevious to easier keys
nmap <c-n> :cnext<cr>
nmap <c-p> :cprevious<cr>

" Easy way to turn line numbers on/off to save space
nmap <leader>ll :call SwitchLineNumbers()<cr>

" ==============================================================================
" *Abbreviations*
" ==============================================================================
" Date and time
iab <expr> dts strftime("%Y-%m-%d %H:%M:%S")


" ==============================================================================
" *Settings*
" ==============================================================================
" Refresh changed files
" Remember info about open buffers on close
set clipboard=unnamed
set viminfo^=%
" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8
" Use Unix as the standard file type
set ffs=unix,dos,mac
" Turn backup off
set nobackup
set nowb
set noswapfile
set autoread
" Increase the history
set history=1000
" Hide buffers that are closed instead of abandoning them
set hid
" Configure backspace so it acts as it should act, namely removing all stuff when used
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" No folding
set nofoldenable
set foldmethod=manual

" === Appearances ===
" Set 7 lines to the cursor - when moving vertically using j/k
set so=5
" Makes it easier to complete commands and stuff
set wildmenu
" Show where we are in the file
set ruler
" Don't redraw while executing macros (good performance config)
set lazyredraw
" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2
" Always show the status line
set laststatus=2
" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

" === Searching ===
" Ignore case when searching
" Global search replace by default
set gdefault
" Ignore case unless explicitly using it (smartcase)
set ignorecase
" When searching try to be smart about cases 
set smartcase
" Highlight search results (but rememer that <cr> will remove hl
set hlsearch
" Makes search act like search in modern browsers
set incsearch
" For regular expressions turn magic on
set magic

" === Text settings ===
" Use spaces instead of tabs
set expandtab
" Be smart when using tabs ;)
set smarttab
" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2
" Don't line break
set linebreak
set textwidth=0
set autoindent
set smartindent
set wrap "Wrap lines

" === Fonts and colors ===
" Enable syntax highlighting
syntax enable
set background=dark
silent! colorscheme solarized
" Set extra options when running in GUI mode
if has("gui_running")
  set guioptions-=T
  set guioptions+=e
  set guitablabel=%M\ %t

  if has("mac") || has("macunix")
    set guifont=Menlo_Regular:h14
  endif
  if has("win32")
    set guifont=Consolas:h14
  endif
endif

" Set the "highlighted" text to underlined
hi Search cterm=underline

" Set better looking characters for `set list`
set listchars=tab:▸\ ,eol:¬

" Good settings to improve performance of terminal vim
let loaded_matchparen=1 " Don't load matchit.vim (paren/bracket matching)
set noshowmatch         " Don't match parentheses/brackets
set nocursorline        " Don't paint cursor line
set nocursorcolumn      " Don't paint cursor column
set scrolljump=8        " Scroll 8 lines at a time at bottom/top

" ==============================================================================
" *Auto commands (run when reading or saving file)*
" ==============================================================================

" Set noexpandtab for certain file types that are white space sensitive
autocmd BufRead,BufNewFile *.styl,*.taskpaper setlocal noexpandtab
autocmd BufRead,BufNewFile *.css,*.html,*.js,*.styl setlocal iskeyword+=-


" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

" ==============================================================================
" *Helper functions*
" ==============================================================================
function! CmdLine(str)
  exe "menu Foo.Bar :" . a:str
  emenu Foo.Bar
  unmenu Foo
endfunction

function! VisualSelection(direction) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  elseif a:direction == 'gv'
    call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
  elseif a:direction == 'replace'
    call CmdLine("%s" . '/'. l:pattern . '/')
  elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

" Returns true if paste mode is enabled. (Credit to @amix.)
function! HasPaste()
  if &paste
    return 'PASTE MODE  '
  en
  return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
  let l:currentBufNum = bufnr("%")
  let l:alternateBufNum = bufnr("#")

  if buflisted(l:alternateBufNum)
    buffer #
  else
    bnext
  endif

  if bufnr("%") == l:currentBufNum
    new
  endif

  if buflisted(l:currentBufNum)
    execute("bdelete! ".l:currentBufNum)
  endif
endfunction

" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion. (Credit to @garybernhardt.)
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction

inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-x><c-o>

" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaCommand(choice_command, selecta_args, vim_command)
  try
    let selection = system(a:choice_command . " | selecta " . a:selecta_args)
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction

" Find all files in all non-dot directories starting in the working directory.
" Fuzzy select one of those. Open the selected file with :e.
nnoremap <leader>f :call SelectaCommand("find * -type f -and -not -path '*/\.*'", "", ":e")<cr>

" js-beautify
nmap <leader>bj mq:%! js-beautify -n -s 2 -m 2 -f -<cr>'q
nmap <leader>bh mq:%! js-beautify -n --type html -s 2 -m 2 -f -<cr>'q

function! SwitchLineNumbers()
  if &number
    set nonumber
  else
    set number
  endif
endfunction
