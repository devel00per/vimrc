" vim: set sw=4 ts=4 sts=4 et foldmarker={,} foldlevel=0 foldmethod=marker:


" SENSIBLE, explicit { ********************************************************

if exists('g:loaded_sensible') || &compatible
  finish
else
  let g:loaded_sensible = 'yes'
endif

if has('autocmd')
  filetype plugin indent on
endif

if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

set nohidden
set backspace=indent,eol,start
set complete-=i
set smarttab

set shortmess+=O

set nrformats-=octal

if !has('nvim') && &ttimeoutlen == -1
  set ttimeout
  set ttimeoutlen=100
endif

set incsearch
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

set laststatus=2
set ruler
set wildmenu

if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif

if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif

if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

if &shell =~# 'fish$' && (v:version < 704 || v:version == 704 && !has('patch276'))
  set shell=/bin/bash
endif

set autoread

if &history < 1000
  set history=1000
endif
if &tabpagemax < 50
  set tabpagemax=50
endif
if !empty(&viminfo)
  set viminfo^=!
endif
set sessionoptions-=options

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
  set t_Co=16
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

inoremap <C-U> <C-G>u<C-U>

"} //SENSIBLE *****************************************************************


" Installing plugins with dependencies { **************************************
"
" Procedure after installation, for all these plugins to work correctly:
" 
" put vim-plug "plug.vim" file in the autoload folder
"
" YouCompleteMe
"		Requires - Python 2.3+ or Python 3+, Vim compiled with Python support + Visual Studio installed on Windows
"		Installation - run ./install.py in the YCM folder, with appropriate completer option [ie. --js-completer]
"
" Tern for Vim - 
" 	Requires - node and npm
"		Installation - run 'npm install' in the tern_for_vim plugin folder
"
" Snippets require Python
"
" Project or global needs -- eslint, babel-eslint, eslint-plugin-react -- for lint to work for React
"
"} //Installing plugins with dependencies *************************************


" vim-plug { ******************************************************************
if has('unix') && empty(glob('~/.vim/autoload/plug.vim'))
  silent execute "!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
"} //vim-plug *****************************************************************


" Installed Plugins { *********************************************************
call plug#begin()
	" ******* UTILITY
    Plug 'editorconfig/editorconfig-vim'
	Plug 'scrooloose/nerdtree'
	Plug 'ctrlpvim/ctrlp.vim'
	Plug 'airblade/vim-rooter'
	Plug 'easymotion/vim-easymotion'
	Plug 'w0rp/ale'
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-unimpaired'                 "]e [e move line up/down and similar, really extensive, check doc
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-repeat'
	Plug 'xolox/vim-misc'
	Plug 'xolox/vim-session'
	Plug 'junegunn/vim-easy-align'              "Aligns stuff nicely, rarely used though
    Plug 'chrisbra/nrrwrgn'
	Plug 'myusuf3/numbers.vim'                  "Toggle between relative/absolute
	Plug 'wellle/targets.vim'					"new text objects like ci,
	Plug 'michaeljsmith/vim-indent-object'		"new indent object cii for same line indent
	" git
	Plug 'airblade/vim-gitgutter'               "]c [c for hunks
	Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
	Plug 'tpope/vim-fugitive'                   "Git wrapper
    Plug 'tpope/vim-rhubarb'                    "Supports fugitive
	" ----------------------------
	" ******* COLOR THEME
	Plug 'reewr/vim-monokai-phoenix'
	" ----------------------------
	" ******* SYNTAX HIGHLIGHTING
    Plug 'Yggdroot/indentLine'                  "Displays indent lines
	Plug 'pangloss/vim-javascript'
	Plug 'luochen1990/rainbow' " For multicolored brackets
    Plug 'neoclide/vim-jsx-improve'
    Plug 'elzr/vim-json'
	Plug 'othree/javascript-libraries-syntax.vim'
    Plug 'leafgarland/typescript-vim'
	" ----------------------------
	" ******* COMPLETION
    Plug 'Valloric/YouCompleteMe'
	Plug 'sirver/ultisnips'
	Plug 'honza/vim-snippets'
	Plug 'epilande/vim-react-snippets'
	Plug 'mattn/emmet-vim'
	Plug 'raimondi/delimitmate'
	Plug 'othree/html5.vim'
call plug#end()

"} //Installed Plugins ********************************************************

" backup files { **************************************************************

set backup
set undofile
if has('unix')
	set directory=~/.vim/.swp//
	set backupdir=~/.vim/.backup//
	set undodir=~/.vim/.undo//
elseif has('windows')
	set directory=$HOME\vimfiles\_swp
	set backupdir=$HOME\vimfiles\_backup
	set undodir=$HOME\vimfiles\_undo
elseif has('maxunix')
	echo 'Meh'
endif

"} //backup files *************************************************************


" Look and feel { *************************************************************

if has('gui_running')
	set guifont=Consolas:h11:b:cANSI:qDRAFT
	set guioptions-=m  "remove menu bar
	set guioptions-=T  "remove toolbar
endif

if !has("gui_running")
	if !empty($CONEMUBUILD) "hacks to work with conemu
		set termencoding=utf8
		set term=xterm
		let &t_AB="\e[48;5;%dm"
		let &t_AF="\e[38;5;%dm"
		inoremap <Char-0x07F> <BS>
		nnoremap <Char-0x07F> <BS>
	endif
	set t_Co=256
	set mouse=a
	set nocompatible
	"let &t_kb = nr2char(127)
	"let &t_kD = "^[[3~"
endif

au GUIEnter * simalt ~x " maximize on start

set background=dark
colorscheme monokai-phoenix

"} //Look and feel ************************************************************


" General options { ***********************************************************

set nohlsearch
set ignorecase
set smartcase
set number
set smartindent
set visualbell
set cursorline
set ttyfast " smoother terminal redrawing

set noshowmatch " no jumping to matching bracket by default

set expandtab " Expand tabs into spaces
set tabstop=4 " how many spaces does a tab equal
set shiftwidth=4 " number of spaces for each indent - 4 is saner than default 8

set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=80
set updatetime=1500 " in ms, this denotes how long it takes from buffer mod to writing swap file to disk

set completeopt+=menuone,longest
set omnifunc=syntaxcomplete#Complete

autocmd FileType javascript.jsx set shiftwidth=2

filetype plugin on " load certain plugins on a per-filetype basis
set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
hi StatusLine ctermfg=15 guifg=#ffff99 ctermbg=239 guibg=#0066cc cterm=bold gui=bold

set foldmethod=indent
set foldlevel=10
set foldcolumn=1

"} //General options **********************************************************


" MAPPINGS { ******************************************************************

" moving lines or selection with Alt+J/K
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

"nmap <F8> :TagbarToggle<CR>
nnoremap <F3> :NumbersToggle<CR>

imap <silent><F2> <Esc>v`^me<Esc>gi<C-o>:call Ender()<CR>
function Ender()
  let endchar = nr2char(getchar())
  execute "normal \<End>a".endchar
  normal `e
endfunction

" <leader>t<char> mappings
let g:tern_map_keys=1

let g:UltiSnipsExpandTrigger = "<C-j>"
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"

inoremap ;; <C-o>A;

nnoremap <A-Left> <C-W><C-H>
nnoremap <A-Right> <C-W><C-L>
nnoremap <A-Up> <C-W><C-K>
nnoremap <A-Down> <C-W><C-J>

vnoremap < <gv
vnoremap > >gv

onoremap iq i'
onoremap iQ i"
onoremap aq a'
onoremap aQ a"

onoremap ia i]
onoremap aa a]

nnoremap <expr> n  'Nn'[v:searchforward] . 'zz' "seach forward with n, backward with N, always
nnoremap <expr> N  'nN'[v:searchforward] . 'zz'

nnoremap ,h :LspHover<CR>

"} //MAPPINGS *****************************************************************


" Plugin Settings { ***********************************************************
let g:EditorConfig_exclude_patterns = ['fugitive://.*'] "Make it work with fugitive

" CTRLP
let g:ctrlp_working_path_mode = 'rc'
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$'

"Easymotion
map <space> <Plug>(easymotion-prefix)
map <space>a <Plug>(easymotion-bd-w)

"NERDtree
map <F2> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
	exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
	exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

"Refresh NERDTree when entering buffers
function! NERDTreeRefresh()
    if &filetype == "nerdtree"
        silent exe substitute(mapcheck("R"), "<CR>", "", "")
    endif
endfunction

autocmd BufEnter * call NERDTreeRefresh()

let g:NERDTreeUpdateOnCursorHold = 0

" ALE settings
let g:ale_sign_error = '●' 
let g:ale_sign_warning = '.'

let g:ale_lint_delay=2000
let g:ale_lint_on_text_changed = 'never' "Only lint on save
let g:ale_lint_on_enter = 0  "Only lint on save
let g:ale_fixers =  {
\   'javascript': ['eslint'],
\   'jsx': ['eslint'],
\   'typescript': ['eslint']
\}

let g:ale_sign_column_always = 1

"EasyAlign
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"jsx
let g:jsx_ext_required = 0

"emmet
let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends' : 'jsx',
\  }
\}



"Rainbow brackets
let g:rainbow_active = 1
autocmd VimEnter * RainbowToggleOn

"bracket highlight
hi MatchParen guibg=TEAL guifg=blue gui=bold
hi MatchParen cterm=none ctermbg=25 ctermfg=15 

"delimitMate 
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
let delimitMate_jump_expansion = 0

"vimSession
let g:session_verbose_messages = 0

"vim-rooter
"let g:rooter_manual_only = 1   "Only trigger rooter with command
"let g:rooter_use_lcd = 1   "Only change CWD for current windows
let g:rooter_resolve_links = 1

"vim-json
let g:vim_json_syntax_conceal = 0

"indentLine
let g:indentLine_noConcealCursor=""

"} //Plugin Settings **********************************************************
