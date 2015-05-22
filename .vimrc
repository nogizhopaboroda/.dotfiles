if filereadable(glob("~/.dotfiles/.neobundle"))
   source ~/.dotfiles/.neobundle
endif

set autochdir


"" NERDTree settings
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"" colors
syntax enable
set background=dark
colorscheme solarized


"" PLUGINS SETTINGS
set wildignore+=*/tmp/*,*/node_modules/*,*.so,*.swp,*.zip
