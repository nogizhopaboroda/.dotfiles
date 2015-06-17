if filereadable(glob("~/.dotfiles/.neobundle"))
   source ~/.dotfiles/.neobundle
endif

set autochdir

"" indentation
set expandtab
set shiftwidth=2
set softtabstop=2

set noswapfile

"" colors
set t_Co=256
syntax enable
set background=dark
colorscheme solarized

"" set case insensitive search as default
set ic

"" search highlighting
set hls
  "" unhighlight
map <silent> <C-Bslash> :noh<CR>

"" my commands
function CopyAndPrintPath( format )
  let path = expand(a:format)
  call system('pbcopy', path)
  echo path
  echo 'Copied to clipboard'
  return path
endfunction

cnoreabbrev fp call CopyAndPrintPath('%:p')
cnoreabbrev fn call CopyAndPrintPath('%:t')


"" PLUGINS SETTINGS

"" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let NERDTreeShowHidden=1 ""show hidden files

"" fuzzy search
set wildignore+=*/tmp/*,*/node_modules/*,*.so,*.swp,*.zip

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


"" colorizer
if version >= 704
	autocmd FileType css,scss,sass,html ColorHighlight
endif

"" commenter
filetype plugin on

"" powerline
set laststatus=2   " Always show the statusline

"" ack
let g:ack_default_options =
              \ " --context 3"

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
