set autochdir
set noswapfile

"" Autoreload files on change
set autoread

"" Terminal style tabs in gui
set guioptions-=e

"" indentation
set expandtab
set shiftwidth=2
set softtabstop=2

au FileType php,python setl sw=4 sts=4 et

"" fix backspace problem in cli vim
set backspace=2

"" enable mouse
set mouse=a

"" colors
set t_Co=256
syntax enable

"" remove background in terminal
hi! Normal ctermbg=NONE
hi! NonText ctermbg=NONE


"" vertical bar cursor shape in insert mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

"" font
set guifont=HackNerdFontComplete-Regular:h11

set cursorline "" highlight current line

"" set case insensitive search as default
set ic

"" search highlighting
set hls
  "" unhighlight
map <silent> <C-Bslash> :noh<CR>


"" fuzzy search
set wildignore+=*/tmp/*,*/node_modules/*,*.so,*.swp,*.zip,*/.sass-cache/*,*/public_html/*,*/public/*
"" commenter
filetype plugin on


set laststatus=2   " Always show the statusline
"" numbers
set relativenumber
set number

