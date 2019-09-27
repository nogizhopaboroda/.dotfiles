"" commands
"" :Gitv - opens gitv plugin
"" :Git <command> - shows git command results in new split pane

let g:cwd = getcwd()

let s:this_dir = expand("<sfile>:h")

function s:importFile( filename )
  let filePath = s:this_dir . '/' . a:filename
  if filereadable(glob(filePath))
     execute "source " . filePath
  else
    echo 'Could not find file: ' . filePath
  endif
endfunction

call s:importFile('vim/neobundle.vim')
call s:importFile('vim/convert_color.vim')

set autochdir
set noswapfile

"" Autoreload files on change
set autoread

"" file types
au BufNewFile,BufRead *.tpl.html set filetype=html.underscore_template
au BufNewFile,BufRead *.es6.html set filetype=html.js
au BufNewFile,BufRead *.blade.php set filetype=blade.html
au BufNewFile,BufRead *.css set filetype=scss.css

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
set background=dark
colorscheme solarized

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

"" not sure if i still need it
inoremap jj <esc>
noremap jj <esc>

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

function ToggleNerdTree()
  if g:NERDTree.IsOpen()
    NERDTreeClose
  else
    exec 'NERDTree ' . g:cwd | wincmd p | NERDTreeFind
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

  "" toggle nerd tree
nmap <silent> <Leader>f :call ToggleNerdTree()<CR>


autocmd FileType javascript,json,typescript nmap <buffer> <C-w>gf <Plug>NodeGotoFile
autocmd FileType javascript,json,typescript nmap <buffer> gf <Plug>NodeTabGotoFile

nmap gD :ALEGoToDefinitionInTab<CR>


"" PLUGINS SETTINGS
"" ----------------

"" GitGutter
set updatetime=500

"" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let NERDTreeShowHidden=1 ""show hidden files

let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''

"" NERDTree Git
let g:NERDTreeIndicatorMapCustom = {
\ "Modified"  : "~",
\ "Staged"    : "✚",
\ "Untracked" : "+",
\ "Renamed"   : "➜",
\ "Dirty"     : "~",
\ "Unmerged"  : "═",
\ "Deleted"   : "-",
\ "Clean"     : "✔︎",
\ 'Ignored'   : '☒',
\ "Unknown"   : "?"
\ }


"" NERDCommenter
let g:NERDCustomDelimiters = {
    \ 'blade': {  'left': '{{-- ', 'right': ' --}}', 'leftAlt': '{{-- ','rightAlt': ' --}}' },
    \ 'scss': {  'left': '/* ', 'right': ' */', 'leftAlt': '/* ','rightAlt': ' */' },
\}
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1


"" airline
  "" add red accent
function! AirlineThemePatch(palette)
  let a:palette.accents.bold_red = [  '#ff0000' , '' , RGB('#ff0000') , '', 'bold'   ]
  let a:palette.accents.gray = [  '#444444' , '' , RGB('#444444') , '', ''   ]
endfunction
let g:airline_theme_patch_func = 'AirlineThemePatch'
call airline#highlighter#add_accent('bold_red')
call airline#highlighter#add_accent('gray')

let g:airline_powerline_fonts = 1
let g:airline_theme           = 'powerlineish'

let g:airline#extensions#whitespace#enabled = 0 "disable whitespace plugin

let g:airline_section_y = ''

call airline#parts#define('directory', {
          \ 'raw': '%{GetPath("%:p:h", "true", "false")}/',
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
    \   'ctermfgs': [RGB('#CDDC39'), RGB('#FF5252'), RGB('#FF9800'), RGB('#4CAF50'), RGB('#E91E63')],
    \   'operators': '_,_',
    \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
    \   'separately': {
    \       '*': {},
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

"" terraform commenter
autocmd FileType terraform setlocal commentstring=#%s

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

"" Taboo plugin format
let g:taboo_tab_format = "%P/%f %m"

"" Vim tagged template highlight plugin
call jspretmpl#register_tag('gql', 'graphql')
call jspretmpl#register_tag('html', 'html')
autocmd FileType javascript,typescript JsPreTmpl

"" Illuminate plugin settings
let g:Illuminate_ftblacklist = ['nerdtree']
let g:Illuminate_highlightUnderCursor = 0

"" FZF.vim plugin settings
command! -bang -nargs=* Search
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=? -complete=dir GFiles
  \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)


nnoremap <space>/ :execute 'Search ' . input('Search string: ')<cr>
nnoremap <C-p> :GFiles<cr>

"" syntax highlight for jest
autocmd BufReadPost,BufNewFile *test.js set filetype=jasmine.javascript syntax=jasmine.javascript
autocmd BufReadPost,BufNewFile *test.ts set filetype=jasmine.typescript syntax=jasmine.typescript

"" highlight files by type
if filereadable(glob("~/.dotfiles/vim/highlight_file_type.vim"))
   source ~/.dotfiles/vim/highlight_file_type.vim
endif


"" macros
if filereadable(glob("~/.dotfiles/vim/macros.vim"))
   source ~/.dotfiles/vim/macros.vim
endif
