if filereadable(glob("~/.dotfiles/.neobundle"))
   source ~/.dotfiles/.neobundle
endif

set autochdir


"" NERDTree settings
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"" colors
set t_Co=256
syntax enable
set background=dark
colorscheme solarized


"" PLUGINS SETTINGS
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
    \       'css': 0,
    \   }
    \}

let g:rainbow_active = 1

"" css
augroup VimCSS3Syntax
	 autocmd!
	 autocmd FileType css setlocal iskeyword+=-
augroup END

"" colourizer
autocmd VimEnter * ColorHighlight
