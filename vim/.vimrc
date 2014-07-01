set nocompatible

filetype plugin indent on
syntax on

" General Config
colorscheme darkrobot 
set background=dark
set guifont=Meslo\ LG\ M:h17
set encoding=utf-8
set ruler

" Highlight current line
set cursorline

" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" Highlight dynamically as pattern is typed
set incsearch

" Automatic commands
if has("autocmd")
	" Enable file type detection
	filetype on
	" Treat .json files as .js
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
endif

" Remember last position in file
if has("autocmd")
	  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
	      \| exe "normal g'\"" | endif
endif
