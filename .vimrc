" ~/.vimrc: Vim configuration without plugins
" Focused on core functionality for occasional editing

" Use bash shell (fixes fish shell issues)
set shell=/bin/bash

" Basic settings
set nocompatible        " Use Vim defaults (not Vi)
set encoding=utf-8      " Use UTF-8 encoding
set laststatus=2        " Always show status line
set ruler               " Show cursor position
set number              " Show line numbers
set history=1000        " Remember more commands and search history
set undolevels=1000     " Use many levels of undo
set title               " Change terminal title
set hidden              " Allow background buffers without saving
set visualbell          " Don't beep
set noerrorbells        " Don't beep
set showmatch           " Show matching brackets
set autoread            " Reload files changed outside vim
set ignorecase          " Case insensitive search...
set smartcase           " ...unless contains uppercase
set showcmd             " Show commands being typed
set nowrap              " Don't wrap lines by default

" No backup/swap files (use version control instead)
set nobackup
set noswapfile

" Color and syntax
syntax enable           " Enable syntax highlighting
set t_Co=256            " 256 colors
set background=dark     " Dark background by default

" Status line configuration
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

" Function for showing search highlight status in statusline
function! HighlightSearch()
  if &hls
    return 'H'
  else
    return ''
  endif
endfunction

" File type detection
filetype on
filetype plugin on
filetype indent on

" File type specifics
autocmd BufRead,BufNewFile *.gohtml set filetype=html
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd FileType javascript set tabstop=2|set shiftwidth=2|set expandtab

" Highlight column 81 for line length guidance
highlight ColorColumn ctermbg=red guibg=red
call matchadd('ColorColumn', '\%81v', 100)

" Discourage arrow keys to build Vim muscle memory
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" TagbarToggle key mapping (comment out if Tagbar not installed)
" nmap <F8> :TagbarToggle<CR>

" Allow local vimrc configurations
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
