"" commands
"" :Gitv - opens gitv plugin
"" :Git <command> - shows git command results in new split pane

let g:cwd = getcwd()

if filereadable(glob("~/.dotfiles/.neobundle"))
   source ~/.dotfiles/.neobundle
endif

set autochdir
set noswapfile

"" file types
au BufNewFile,BufRead .plugins_list set filetype=vim

"" indentation
set expandtab
set shiftwidth=2
set softtabstop=2

au FileType html,php setl sw=4 sts=4 et

"" colors
set t_Co=256
syntax enable
set background=dark
colorscheme solarized

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
function CopyAndPrintPath( format, relative )
  let path = expand(a:format)
  if a:relative == "true"
    let path = substitute(path, g:cwd . "/", "", "")
  endif
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

cnoreabbrev fp call CopyAndPrintPath('%:p', "true")
cnoreabbrev fa call CopyAndPrintPath('%:p', "false")
cnoreabbrev fn call CopyAndPrintPath('%:t', "false")

cnoreabbrev pcd :execute 'cd ' . cwd

"" my keymappings
nmap <silent> <D-A-Up> :wincmd k<CR>
nmap <silent> <D-A-Down> :wincmd j<CR>
nmap <silent> <D-A-Left> :wincmd h<CR>
nmap <silent> <D-A-Right> :wincmd l<CR>

nnoremap <leader>v :call ToggleVerticalLine()<cr>


"" PLUGINS SETTINGS
"" ----------------

"" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let NERDTreeShowHidden=1 ""show hidden files

"" fuzzy search
set wildignore+=*/tmp/*,*/node_modules/*,*.so,*.swp,*.zip,*/.sass-cache/*

"" rainbow brackets
let g:rainbow_conf = {
    \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
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


"" macros
autocmd Filetype javascript call ApplyJsMacros()
function ApplyJsMacros()
  map mf afunction(){}ki
  map mF omf
  map mc oif(){}k3li
  map mC oif(){} else {}2k3li
endfunction

autocmd Filetype html call ApplyHtmlMacros()
function ApplyHtmlMacros()
  map md o<div class=""></div>ki
endfunction

autocmd Filetype css,scss,sass,html call ApplyStylesMacros()
function ApplyStylesMacros()
  map mc o. {}ka
  map mi o# {}ka
  map mt odiv {}k3li
  map mm o@media () {}k8li
endfunction
