" NERDTress File highlighting

"" :XtermColorTable - shows color table

function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
  exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
  exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

function! NERDTreeHighlightDirectory(directory, fg, bg, guifg, guibg)
  exec 'autocmd FileType nerdtree highlight ' . a:directory . ' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
  exec 'autocmd FileType nerdtree syn match ' . a:directory . ' #'. a:directory .'/$#  containedin=NERDTreeDir'
endfunction

call NERDTreeHighlightFile('json', '226', 'none', '#ffff00', 'NONE')
call NERDTreeHighlightFile('js', '208', 'none', '#ff8700', 'NONE')
call NERDTreeHighlightFile('es6.js', '209', 'none', '#ff875f', 'NONE')
call NERDTreeHighlightFile('html', '35', 'none', '#00af5f', 'NONE')
call NERDTreeHighlightFile('tpl.html', '36', 'none', '#00af87', 'NONE')
call NERDTreeHighlightFile('styl', '51', 'none', '#00ffff', 'NONE')
call NERDTreeHighlightFile('css', '50', 'none', '#00ffd7', 'NONE')
call NERDTreeHighlightFile('php', '132', 'none', '#af5f87', 'NONE')
call NERDTreeHighlightFile('blade.php', '34', 'none', '#00af00', 'NONE')
call NERDTreeHighlightFile('gitconfig', '242', 'none', '#6c6c6c', 'NONE')
call NERDTreeHighlightFile('gitignore', '242', 'none', '#6c6c6c', 'NONE')

call NERDTreeHighlightDirectory('node_modules', '242', 'none', '#6c6c6c', 'NONE')
call NERDTreeHighlightDirectory('vendor', '242', 'none', '#6c6c6c', 'NONE')
call NERDTreeHighlightDirectory('.git', '242', 'none', '#6c6c6c', 'NONE')
call NERDTreeHighlightDirectory('.vagrant', '242', 'none', '#6c6c6c', 'NONE')
call NERDTreeHighlightDirectory('public', '242', 'none', '#6c6c6c', 'NONE')
call NERDTreeHighlightDirectory('public_html', '242', 'none', '#6c6c6c', 'NONE')

call NERDTreeHighlightDirectory('test', '29', 'none', '#00875f', 'NONE')
call NERDTreeHighlightDirectory('tests', '29', 'none', '#00875f', 'NONE')

