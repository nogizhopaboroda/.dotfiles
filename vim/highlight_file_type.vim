" NERDTree File highlighting

"" :XtermColorTable - shows color table


if filereadable(glob("~/.dotfiles/vim/convert_color.vim"))
  source ~/.dotfiles/vim/convert_color.vim
endif


function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
  exec 'syn match file_' . a:extension .' "\(\S\+ \)*\S\+\.' . a:extension .'\>" containedin=EasyTreeFile'
  exec 'hi file_' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
endfunction

function! NERDTreeHighlightDirectory(directory, fg, bg, guifg, guibg)
  exec 'syn match directory_' . a:directory . ' /'. a:directory .'/  containedin=EasyTreeDir'
  exec 'highlight directory_' . a:directory . ' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
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



autocmd FileType easytree call s:netrw_settings()
function! s:netrw_settings() abort
  for [key, val] in items(s:files_colors)
    call NERDTreeHighlightFile(key, RGB(val), 'none', val, 'NONE')
  endfor

  for [key, val] in items(s:directories_colors)
    call NERDTreeHighlightDirectory(key, RGB(val), 'none', val, 'NONE')
  endfor
endfunction
