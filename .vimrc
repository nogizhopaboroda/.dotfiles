"" commands
"" :Gitv - opens gitv plugin
"" :Git <command> - shows git command results in new split pane

let g:cwd = getcwd()

if filereadable(glob("~/.dotfiles/vim/neobundle.vim"))
   source ~/.dotfiles/vim/neobundle.vim
endif

set autochdir
set noswapfile

"" file types
au BufNewFile,BufRead *.tpl.html set filetype=html.underscore_template
au BufNewFile,BufRead *.blade.php set filetype=blade.html

"" indentation
set expandtab
set shiftwidth=2
set softtabstop=2

au FileType html,php setl sw=4 sts=4 et

"" fix backspace problem in cli vim
set backspace=2

"" enable mouse
set mouse=a

"" colors
set t_Co=256
syntax enable
set background=dark
colorscheme solarized

"" vertical bar cursor shape in insert mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

"" font
set guifont=Hack:h11

set cursorline "" highlight current line

"" set case insensitive search as default
set ic

"" search highlighting
set hls
  "" unhighlight
map <silent> <C-Bslash> :noh<CR>

"" my commands
function GetPath( format, relative )
  let path = expand(a:format)
  if a:relative == "true"
    let path = substitute(path, g:cwd . "/", "", "")
  endif
  return path
endfunction

function CopyAndPrintPath( format, relative )
  let path = GetPath( a:format, a:relative )
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

cnoreabbrev fp call CopyAndPrintPath('%:p', "true")
cnoreabbrev fa call CopyAndPrintPath('%:p', "false")
cnoreabbrev fn call CopyAndPrintPath('%:t', "false")

cnoreabbrev pcd :execute 'cd ' . cwd

cnoreabbrev presentation call SetFontSize(18)
cnoreabbrev stop_presentation call SetFontSize(11)

"" my keymappings
nmap <silent> <D-A-Up> :wincmd k<CR>
nmap <silent> <D-A-Down> :wincmd j<CR>
nmap <silent> <D-A-Left> :wincmd h<CR>
nmap <silent> <D-A-Right> :wincmd l<CR>

  "" jump to start/end of word by alt-arrow
map f e
map b b
inoremap f <C-o>e
inoremap b <C-o>b

  "" show/hide vertical line
nmap <silent> <leader>v :call ToggleVerticalLine()<CR>

"" PLUGINS SETTINGS
"" ----------------

"" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let NERDTreeShowHidden=1 ""show hidden files

"" NERDCommenter
let g:NERDCustomDelimiters = {
    \ 'blade': {  'left': '{{-- ', 'right': ' --}}', 'leftAlt': '{{-- ','rightAlt': ' --}}' },
\}

"" airline
  "" add red accent
function! AirlineThemePatch(palette)
  let a:palette.accents.bold_red = [  '#ff0000' , '' , 160 , '', 'bold'   ]
  let a:palette.accents.gray = [  '#444444' , '' , 59 , '', ''   ]
endfunction
let g:airline_theme_patch_func = 'AirlineThemePatch'
call airline#highlighter#add_accent('bold_red')
call airline#highlighter#add_accent('gray')

let g:airline_powerline_fonts = 1
let g:airline_theme           = 'powerlineish'

let g:airline#extensions#whitespace#enabled = 0 "disable whitespace plugin

let g:airline_section_y = ''

call airline#parts#define('directory', {
          \ 'raw': '%{GetPath("%:p:h", "true")}/',
          \ 'accent': 'gray',
          \ })
call airline#parts#define('file', {
          \ 'raw': '%f '
          \ })
call airline#parts#define('change_sign', {
          \ 'raw': '%m',
          \ 'accent': 'red',
          \ })
call airline#parts#define('readonly', {
          \ 'raw': '%{airline#util#wrap(airline#parts#readonly(),0)}',
          \ 'accent': 'red',
          \ })

let g:airline_section_c = airline#section#create(['directory', 'file', 'change_sign', 'readonly'])

let g:airline#extensions#hunks#non_zero_only = 1

" vim-powerline symbols
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'

let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n'  : 'N',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'c'  : 'C',
      \ 'v'  : 'V',
      \ 'V'  : 'V',
      \ 's'  : 'S',
      \ 'S'  : 'S',
      \ }

"" fuzzy search
set wildignore+=*/tmp/*,*/node_modules/*,*.so,*.swp,*.zip,*/.sass-cache/*,*/public_html/*,*/public/*

"" rainbow brackets
let g:rainbow_conf = {
    \   'guifgs': ['#CDDC39', '#FF5252', '#FF9800', '#4CAF50', '#E91E63'],
    \   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
    \   'operators': '_,_',
    \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
    \   'separately': {
    \       '*': {},
    \       'tex': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
    \       },
    \       'lisp': {
    \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
    \       },
    \       'vim': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
    \       },
    \       'html': 0,
    \   }
    \}

let g:rainbow_active = 1

"" ctrlp
let g:ctrlp_prompt_mappings = {
    \ 'PrtInsert("c")': ['<c-v>'],
\}

"" css
augroup VimCSS3Syntax
	 autocmd!
	 autocmd FileType css setlocal iskeyword+=-
augroup END

"" commenter
filetype plugin on

"" powerline
set laststatus=2   " Always show the statusline

"" ack
let g:ackprg = 'pt --column'
let g:ack_default_options =
              \ " --context=2"

"" numbers
set relativenumber
set number

"" repeat.vim
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

"" github markdown preview
augroup markdown
      au!
      au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END


"" unite settings
  "" Custom ignores
call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
      \ 'ignore_pattern', join([
      \ '\.git/',
      \ 'tmp/',
      \ '.sass-cache',
      \ 'node_modules/',
      \ 'bower_components/',
      \ 'dist/',
      \ '.vagrant/',
      \ '.pyc',
      \ ], '\|'))

let g:unite_prompt='» '

if executable('pt')
  let g:unite_source_rec_async_command = 'pt --nocolor --nogroup -g'
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column --smart-case'
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_grep_encoding = 'utf-8'
endif

" nnoremap <C-k> :Unite file_rec/async<cr>
nnoremap <C-p> :execute 'Unite -start-insert file_rec/async:' . cwd<cr>
"" nnoremap <C-k> :Unite grep:.<cr>
nnoremap <space>/ :execute 'Unite grep:' . cwd<cr>


"" surround custom mappings
let g:surround_custom_mapping = {}
let g:surround_custom_mapping.javascript = {
    \ 'f':  "function(){ \r }",
    \ 't':  "try { \r } catch(e) {}",
    \ 'i':  "if(){ \r }"
    \ }
let g:surround_custom_mapping.scss = {
    \ '.':  ". { \r }",
    \ '#':  "# { \r }"
    \ }
let g:surround_custom_mapping.css = {
    \ '.':  ". { \r }",
    \ '#':  "# { \r }"
    \ }

"" MatchTagAlways plugin
nnoremap <leader>% :MtaJumpToOtherTag<cr>

"" IndexedSearch settings
let g:indexed_search_shortmess = 1
let g:indexed_search_numbered_only = 1


"" Change Case plugin (Casetrate)
let g:casetrate_leader = '\t'


"" highlight files by type
if filereadable(glob("~/.dotfiles/vim/highlight_file_type.vim"))
   source ~/.dotfiles/vim/highlight_file_type.vim
endif


"" macros
if filereadable(glob("~/.dotfiles/vim/macros.vim"))
   source ~/.dotfiles/vim/macros.vim
endif
