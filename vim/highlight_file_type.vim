" NERDTree File highlighting

"" :XtermColorTable - shows color table


if filereadable(glob("~/.dotfiles/vim/convert_color.vim"))
  source ~/.dotfiles/vim/convert_color.vim
endif

function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
  exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
  exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

function! NERDTreeHighlightDirectory(directory, fg, bg, guifg, guibg)
  exec 'autocmd FileType nerdtree highlight ' . a:directory . ' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
  exec 'autocmd FileType nerdtree syn match ' . a:directory . ' #'. a:directory .'/$#  containedin=NERDTreeDir'
endfunction


let s:files_colors = {
  \ 'md'       	: '#5f875f',
  \
  \ 'json'     	: '#ffff00',
  \ 'js'	: '#ff8700',
  \ 'jsx'	: '#ffaf00',
  \
  \ 'ts'	: '#afdfff',
  \ 'tsx'	: '#afffdf',
  \
  \ 'es6.js'	: '#ff875f',
  \ 'html'	: '#00af5f',
  \ 'tpl.html'	: '#00af87',
  \
  \ 'styl'	: '#00ffff',
  \ 'css'	: '#00ffd7',
  \
  \ 'php'	: '#af5f87',
  \ 'blade.php' : '#00af00',
  \
  \ 'gitconfig' : '#6c6c6c',
  \ 'gitignore' : '#6c6c6c'
\}

for [key, val] in items(s:files_colors)
  call NERDTreeHighlightFile(key, RGB(val), 'none', val, 'NONE')
endfor

let s:directories_colors = {
  \'node_modules'	: '#6c6c6c',
  \'vendor'		: '#6c6c6c',
  \
  \'.git'		: '#6c6c6c',
  \
  \'.vagrant'		: '#6c6c6c',
  \
  \'public'		: '#6c6c6c',
  \'public_html'	: '#6c6c6c',
  \
  \'test'		: '#00875f',
  \'tests'		: '#00875f'
\}

for [key, val] in items(s:directories_colors)
  call NERDTreeHighlightDirectory(key, RGB(val), 'none', val, 'NONE')
endfor
