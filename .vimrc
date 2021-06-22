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
set background=dark

" Basic vim tweaks
syntax enable           " enable syntax processing
set laststatus=2		" always showstatusline
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
"set relativenumber  "use relative numbers


" No auto backups/swapfiles. Use git etc
set nobackup	
set noswapfile

"" statusline
set laststatus=2
set statusline=
set statusline+=%7*\[%n]                                  "buffernr
set statusline+=%1*\ %<%F\                                "File+path
set statusline+=%2*\ %y\                                  "FileType
set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\            "Encoding2
set statusline+=%4*\ %{&ff}\                              "FileFormat (dos/unix..) 
set statusline+=%5*\ %{&spelllang}\%{HighlightSearch()}\  "Spellanguage & Highlight on?
set statusline+=%8*\ %=\ row:%l/%L\ (%03p%%)\             "Rownumber/total (%)
set statusline+=%9*\ col:%03c\                            "Colnr
set statusline+=%0*\ \ %m%r%w\ %P\ \                      "Modified? Readonly? Top/bot.

function! HighlightSearch()
  if &hls
    return 'H'
  else
    return ''
  endif
endfunction


autocmd BufRead,BufNewFile *.gohtml set filetype=html
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

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


" ===== Allow local vimrc configs ========
if filereadable($HOME . "/.vimrc.local")
	source ~/.vimrc.local
endif
