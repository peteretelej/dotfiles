set shell=/bin/bash " use bash shell, fish shell fix

set nocompatible        " be iMproved

" COLORSCHEMES
"
" - if on xterm/ubuntu; add to bashrc - export TERM='xterm-256color'
"
" Favorite :colors 
"	(dark)- gruvbox,xoria256,molokai, vividchalk, inkpot, wombat, zenburn,,
"	candy, 	grb256, distinguished, candycode
"	(light)- papercolor, github
set t_Co=256 "256 colors
"set background=dark
colorscheme molokai

" Basic vim tweaks
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
set relativenumber  "use relative numbers


" No auto backups/swapfiles. Use git etc
set nobackup	
set noswapfile

"" statusline <- Replaced by airline
"set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

autocmd BufRead,BufNewFile *.gohtml set filetype=html
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

autocmd FileType javascript set formatprg=prettier\ --stdin

" use double space as tabstop in js
autocmd FileType javascript set tabstop=2|set shiftwidth=2|set expandtab

"au FileType json setlocal equalprg=python\ -m\ json.tool " fix json gg=G formatting

"==============[ Highlight col 81 ]=============================
"set colorcolumn=81 "old method
highlight ColorColumn ctermbg=red guibg=red
call matchadd('ColorColumn', '\%81v', 100)

"======[ CAUTION: DON'T FEED THE ZOMBIES use vim conventions]============
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

" use vim-plug and custom directory plugged
call plug#begin('~/.vim/plugged')

" EXAMPLES: https://github.com/junegunn/vim-plug#example

" fzf fuzzy finder 
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
nnoremap <c-p> :FZF<cr> " map  ctrlp's <c-p> to FZF


Plug 'flazz/vim-colorschemes' " colorschemes: uses ~/.vim/colors/*
Plug 'SirVer/ultisnips'

" Git plugins
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" tagbar 
Plug 'majutsushi/tagbar'

Plug 'posva/vim-vue'

Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
let g:jsx_ext_required = 1

Plug 'tpope/vim-commentary' "comments

" unobstructive scratch buffer
Plug 'mtth/scratch.vim'

" tmuxline
Plug 'edkolev/tmuxline.vim'
let g:tmuxline_separators = {
			\ 'left' : '',
			\ 'left_alt': '>',
			\ 'right' : '',
			\ 'right_alt' : '<',
			\ 'space' : ' '}

"# better vim statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
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


" neocomplete
if has('lua')
	Plug 'Shougo/neocomplete.vim'
	let g:neocomplete#enable_at_startup = 1
end

" language: go
Plug 'fatih/vim-go', { 'tag': '*' }

" Initialize plugin system
call plug#end()


" ===== Allow local vimrc configs ========
if filereadable($HOME . "/.vimrc.local")
	source ~/.vimrc.local
endif
