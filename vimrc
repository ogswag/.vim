" ============================================================================
" PLUGINS & PACKAGE MANAGEMENT
" ============================================================================

" ---
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim  '
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" ---
call plug#begin()

" Fuzzy search and file opening
Plug 'ctrlpvim/ctrlp.vim'

" Commenting code
Plug 'tpope/vim-commentary'

" Convert text to Title Case
Plug 'christoomey/vim-titlecase'

" Language packs for syntax highlighting
Plug 'sheerun/vim-polyglot'

" Sync themes with system style
" Plug 'vimpostor/vim-lumen'

" Highlight trailing whitespace
Plug 'ntpeters/vim-better-whitespace'

call plug#end()

let g:nord_italic = 0
let g:nord_italic_comments = 0

" ============================================================================
" GENERAL SETTINGS & BEHAVIOR
" ============================================================================
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯЖ;ABCDEFGHIJKLMNOPQRSTUVWXYZ:,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
" switch between layouts using Ctrl+^ in insert mode
set keymap=russian-jcukenwin
set iminsert=0  " Start with English input
set imsearch=0  " Start search with English

set nocompatible
filetype plugin indent on
syntax on

set clipboard=unnamed

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set fileformats=unix,mac

set hidden confirm
set scrolloff=0
set sidescroll=1 sidescrolloff=3
set nostartofline
set virtualedit=block
set display=lastline
set laststatus=2
set ruler
set belloff=all shortmess+=Ic
set title
set noswapfile
set nospell spelllang=en_gb,ru_yo
set showmatch
set autoindent shiftwidth=4 softtabstop=-1 expandtab
set smartindent
set smarttab
set backspace=indent,eol,start
set mouse=a
set autochdir
set autoread

" ============================================================================
" TEXT & DISPLAY FORMATTING
" ============================================================================

set nowrap breakindent breakindentopt=sbr,list:-1 linebreak nojoinspaces
set list listchars=tab:›\ ,nbsp:␣,trail:·,extends:…,precedes:… showbreak=↪
set fillchars=fold:\ ,vert:│
set colorcolumn=110
set textwidth=110
set cursorline
set cursorlineopt=number
set nu rnu
set hlsearch incsearch ignorecase smartcase

" Centre search results on screen
nnoremap n nzz
nnoremap N Nzz

" ============================================================================
" KEY MAPPINGS
" ============================================================================

nnoremap j gj
nnoremap k gk

nnoremap <silent> <C-q> <End>a;<C-c>j
imap <silent> <C-q> <End>;<Down>

imap <silent> <C-a> <C-o>I
imap <silent> <C-e> <C-o>A

imap <silent> <C-k> <up>
imap <silent> <C-j> <down>
imap <silent> <C-h> <left>
imap <silent> <C-l> <right>

" ============================================================================
" INTERFACE & APPEARANCE
" ============================================================================

set ttimeout ttimeoutlen=25
set langmenu=en_US.UTF-8
language messages en_US.UTF-8
set splitbelow splitright

set wildmenu wildoptions=pum,fuzzy pumheight=20
set wildignore=*.o,*.obj,*.bak,*.exe,*.swp,tags,*.out
set completeopt=menu,popup completepopup=highlight:Pmenu

if has("gui_running")
    set guifont=Input\ Mono:h13
    set go-=r
    set go-=l
    set go-=L
endif

" ============================================================================
" UNDO & PERSISTENCE
" ============================================================================

function! CheckUndoDir()
    let l:undo_dir = expand('~/.vimUndoDir')
    if !isdirectory(l:undo_dir)
        call mkdir(l:undo_dir, 'p')
    endif
endfunction

call CheckUndoDir()
set undodir=~/.vimUndoDir
set undolevels=1000
set undofile
set viminfo='200,<500,s32

" ============================================================================
" COLORS & THEMES
" ============================================================================

augroup colorscheme_change | au!
    au ColorScheme jellybeans hi Normal ctermbg=NONE guibg=NONE
    au ColorScheme habamax hi Normal ctermbg=NONE guibg=NONE
    au ColorScheme habamax hi Comment ctermfg=95 guifg=NONE
    au ColorScheme habamax hi SpellBad cterm=underline ctermfg=124 ctermbg=NONE guifg=#af0000 gui=underline guibg=NONE
    au ColorScheme sorbet hi Normal ctermbg=NONE guibg=NONE
    au ColorScheme default hi Normal ctermbg=NONE guibg=NONE
    au ColorScheme default hi LineNr ctermfg=8 guifg=gray
    au ColorScheme default hi CursorLineNr cterm=NONE ctermfg=12
    au ColorScheme default hi Special ctermfg=5
    au ColorScheme default hi PreProc ctermfg=5
augroup END

function! EnableTermGuicolorsIfSupported()
    if !has('termguicolors')
        return
    endif

    if ($COLORTERM ==# 'truecolor' || $COLORTERM ==# '24bit') ||
        \ ($TERM ==# 'xterm-kitty') ||
        \ ($TERM_PROGRAM ==# 'WezTerm') ||
        \ ($TERM_PROGRAM ==# 'vscode') ||
        \ (exists('$VTE_VERSION') && $VTE_VERSION >= 3600)

        if &term =~# '^screen' || &term =~# '^tmux'
            let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
            let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
        endif

        set termguicolors

        return 1
    endif

    return 0
endfunction

call EnableTermGuicolorsIfSupported()

function! AutoThemeByTime() abort
  let hour = str2nr(strftime('%H'))
  if hour >= 8 && hour < 16
    colorscheme tokyonight-day
  else
    colorscheme jellybeans
  endif
endfunction

augroup AutoTheme
  autocmd!
  autocmd VimEnter * call AutoThemeByTime()
augroup END

" ============================================================================
" AUTOCOMMANDS & FORMATTING OPTIONS
" ============================================================================

autocmd BufNewFile,BufRead,BufWinEnter,FileType,OptionSet * set formatoptions-=t formatoptions-=l formatoptions-=c formatoptions-=r formatoptions-=o formatoptions-=q
autocmd BufNewFile,BufRead,BufWinEnter,FileType,OptionSet * setlocal formatoptions-=t formatoptions-=l formatoptions-=c formatoptions-=r formatoptions-=o formatoptions-=q
