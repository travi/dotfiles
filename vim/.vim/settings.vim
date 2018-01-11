filetype plugin indent on
syntax on

" General Config
colorscheme icansee
set background=dark
set guifont=Source\ Code\ Pro
set autoindent
set ruler
set visualbell
set showcmd

set t_BE=                       " Disable braketed paste mode

set scrolloff=10                " Start scrolling this number of lines from top/bottom

set smarttab                    " Make Tab work fine with spaces
set backspace=indent,eol,start  " Make backspace work as expected on all systems

set showmatch                   " show matching brackets
set matchtime=5                 " tenths of a second to blink matching brackets

set list                        " show tabs, trailings spaces, ...
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<

set encoding=utf-8              " Let Vim use utf-8 internally
set fileencoding=utf-8          " Default for new files
set termencoding=utf-8          " Terminal encoding
set fileformats=unix,dos,mac    " support all three, in this order
set fileformat=unix             " default file format

set nonu                        " Turn off line numbering
set lbr                         " Wrap text
set cursorline                  " Highlight current line
hi CursorLine term=underline cterm=underline gui=underline guibg=Black ctermbg=Black

set hlsearch                    " Highlight searches
set ignorecase                  " Ignore case of searches
set smartcase                   " Unless a capital letter is used in the search
set incsearch                   " Highlight dynamically as pattern is typed
