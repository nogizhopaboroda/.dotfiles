"" commands
"" :Gitv - opens gitv plugin
"" :Git <command> - shows git command results in new split pane


let s:this_dir = expand("<sfile>:h")

function ImportFile( filename )
  let filePath = s:this_dir . '/' . a:filename
  if filereadable(glob(filePath))
     execute "source " . filePath
  else
    echo 'Could not find file: ' . filePath
  endif
endfunction

let g:cwd = getcwd()

call ImportFile('vim/convert_color.vim')

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

" "" not sure if i still need it
" inoremap jj <esc>
" noremap jj <esc>

"" copy to system clipboard
vnoremap <M-c> "+y

"" Alt + ->  -  go to the beginning of the next word
nmap <A-Right> w
imap <A-Right> <C-o>w
"" Alt + ->  -  go to the beginning of the next word
nmap <A-Left> b
imap <A-Left> <C-o>b

"" Alt + ->  -  go to the beginning of the next word
nmap <C-e> $
imap <C-e> <C-o>$
"" Alt + ->  -  go to the beginning of the next word
nmap <C-a> 0
imap <C-a> <C-o>0



"" my commands
function GetPath( format, relative, print_line )
  let path = expand(a:format)
  if a:relative == "true"
    let path = substitute(path, g:cwd . "/\\?", "", "")
  endif
  if a:print_line == "true"
    let path = path . ":" . line(".")
  endif
  return path
endfunction

function CopyAndPrintPath( format, relative, print_line )
  let path = GetPath( a:format, a:relative, a:print_line )
  call system('pbcopy', path)
  echo path
  echo 'Copied to clipboard'
  return path
endfunction

function ToggleVerticalLine()
  if &cursorcolumn == 0
    set cursorcolumn
  else
    set nocursorcolumn
  endif
endfunction

function SetFontSize( size )
  let &guifont = substitute(&guifont, ':h\d\+$', ':h'.a:size, '')
endfunction

cnoreabbrev fp call CopyAndPrintPath('%:p', "true", "false")
cnoreabbrev fpl call CopyAndPrintPath('%:p', "true", "true")
cnoreabbrev fa call CopyAndPrintPath('%:p', "false", "false")
cnoreabbrev fal call CopyAndPrintPath('%:p', "false", "true")
cnoreabbrev fn call CopyAndPrintPath('%:t', "false", "false")
cnoreabbrev fnl call CopyAndPrintPath('%:t', "false", "true")
cnoreabbrev fnn call CopyAndPrintPath('%:r', "false", "false")

cnoreabbrev pcd :execute 'cd ' . cwd

cnoreabbrev presentation call SetFontSize(18)
cnoreabbrev stop_presentation call SetFontSize(11)

"" my keymappings
nmap <silent> <D-A-Up> :wincmd k<CR>
nmap <silent> <D-A-Down> :wincmd j<CR>
nmap <silent> <D-A-Left> :wincmd h<CR>
nmap <silent> <D-A-Right> :wincmd l<CR>

nmap <silent> <C-S-Up> :wincmd k<CR>
nmap <silent> <C-S-Down> :wincmd j<CR>
nmap <silent> <C-S-Left> :wincmd h<CR>
nmap <silent> <C-S-Right> :wincmd l<CR>

nmap <silent> <S-Right> :tabnext<CR>
nmap <silent> <S-Left> :tabprev<CR>

  "" jump to start/end of word by alt-arrow
map f e
map b b
inoremap f <C-o>e
inoremap b <C-o>b

  "" show/hide vertical line
nmap <silent> <leader>v :call ToggleVerticalLine()<CR>




call ImportFile('vim/plugins.vim')


"" highlight files by type
call ImportFile('vim/highlight_file_type.vim')


"" macros
call ImportFile('vim/macros.vim')
