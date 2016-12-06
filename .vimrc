set nocompatible        " be iMproved

" COLORSCHEMES
"
" - if on xterm/ubuntu; add to bashrc - export TERM='xterm-256color'
"
" Favorite :colors 
"	(dark)- gruvbox,xoria256,molokai, vividchalk, inkpot, wombat, zenburn,,
"	candy, 	grb256, distinguished, 
"		candycode
"	(light)- papercolor, github
set t_Co=256 "256 colors
"set background=dark
colorscheme molokai

syntax enable           " enable syntax processing
set laststatus=2		" always showstatusline
set statusline=%f 		"tail of the filename
set ruler
set number              " show line numbers
"set cursorline          " highlight current line
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set title                " change the terminal's title
set hidden 		" allow unsaved buffers
set visualbell		" don't beep
set noerrorbells	" don't beep
set encoding=utf-8              " Set default encoding to UTF-8
set showmatch		" show matching parenthesis
set autoread 		" autoreload file edited outside vim
set ignorecase smartcase " search only case sensitive if has uppercase
set showcmd            " show commands being typed
set nowrap		" switch wrap off

" Use git to protect data. No auto backups/swapfiles
set nobackup	
set noswapfile

"" statusline <- Replaced by airline
"set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

autocmd BufRead,BufNewFile *.gohtml set filetype=html

filetype off                  " required by Vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}


"=============[ My VIM plugins ]====================================

Plugin 'tpope/vim-commentary'

""======= CAUTION: DO NOT FEED THE ZOMBIES, use ctrlp =========
"" NERDTree
"Plugin 'scrooloose/nerdtree'
"map <C-k> :NERDTreeToggle<CR> " Map NERDTree Toggle
"let g:NERDTreeDirArrowExpandable = '▸'
"let g:NERDTreeDirArrowCollapsible = '▾'
""autocmd StdinReadPre * let s:std_in=1 	" auto open NERDTree if no files specified
""autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif " auto open cont.. 
""autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " autoclosevim
"let g:NERDTreeShowHidden=1

Plugin 'wakatime/vim-wakatime' 

"======================[ GO plugins ]=======================
Plugin 'fatih/vim-go' " Rem to :GoInstallBinaries & :GoUpdateBinaries

"gotags
let g:tagbar_type_go = {
			\ 'ctagstype' : 'go',
			\ 'kinds'     : [
			\ 'p:package',
			\ 'i:imports:1',
			\ 'c:constants',
			\ 'v:variables',
			\ 't:types',
			\ 'n:interfaces',
			\ 'w:fields',
			\ 'e:embedded',
			\ 'm:methods',
			\ 'r:constructor',
			\ 'f:functions'
			\ ],
			\ 'sro' : '.',
			\ 'kind2scope' : {
			\ 't' : 'ctype',
			\ 'n' : 'ntype'
			\ },
			\ 'scope2kind' : {
			\ 'ctype' : 't',
			\ 'ntype' : 'n'
			\ },
			\ 'ctagsbin'  : 'gotags',
			\ 'ctagsargs' : '-sort -silent'
			\ }

Plugin 'majutsushi/tagbar'

Plugin 'ctrlpvim/ctrlp.vim'
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = 0 " prevent ctrlp from autosetting workdir . irksome af on Monorepos
let g:ctrlp_custom_ignore = '\v[\/](Godeps|vendor|dist)|(\.(git|svn))$' " hide directories from ctlrp

Plugin 'mtth/scratch.vim'

" tmuxline
Plugin 'edkolev/tmuxline.vim'
let g:tmuxline_separators = {
			\ 'left' : '',
			\ 'left_alt': '>',
			\ 'right' : '',
			\ 'right_alt' : '<',
			\ 'space' : ' '}


" # Theme
Plugin 'flazz/vim-colorschemes'  " rem to copy all ./colors/*.vim to ~/.vim/colors

" # Neocomplete
"Plugin 'Shougo/neocomplete.vim'
"let g:neocomplete#enable_at_startup = 1
if has('lua')
	Plugin 'Shougo/neocomplete.vim'
	let g:neocomplete#enable_at_startup = 1
end

"# better vim statusline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
let g:airline_theme ='papercolor'
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'
" /# better vim statusline

" Surround
Plugin 'tpope/vim-surround'

" gitgutter
Plugin 'airblade/vim-gitgutter'

" vim-json
Plugin 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0

"syntastic
Plugin 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']

"========== Javascript Plugins ====================
Plugin 'pangloss/vim-javascript'

" jsx support
Plugin 'mxw/vim-jsx'

Plugin 'StanAngeloff/php.vim'

"========== End of  Plugins =======================
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


"==============[ Highlight col 81 ]=============================
"set colorcolumn=81 "old method
highlight ColorColumn ctermbg=red guibg=red
call matchadd('ColorColumn', '\%81v', 100)

"===============[ Set relatvenumber ]============================
set relativenumber
set number

"======[ CAUTION: DON'T FEED THE ZOMBIES]=======================
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
"" Allow mouse if exists, :shrug:
"if has('mouse')
"	set mouse=a
"endif

" TagbarToggle Key mapping
nmap <F8> :TagbarToggle<CR>

" ===== Allow local vimrc configs ========
if filereadable($HOME . "/.vimrc.local")
	source ~/.vimrc.local
endif
