" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
  exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
  exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('json', '226', 'none', '#ffff00', 'NONE')
call NERDTreeHighlightFile('js', '208', 'none', '#ff8700', 'NONE')
call NERDTreeHighlightFile('es6.js', '209', 'none', '#ff875f', 'NONE')
call NERDTreeHighlightFile('html', '35', 'none', '#00af5f', 'NONE')
call NERDTreeHighlightFile('styl', '51', 'none', '#00ffff', 'NONE')
call NERDTreeHighlightFile('css', '50', 'none', '#00ffd7', 'NONE')
call NERDTreeHighlightFile('php', '132', 'none', '#af5f87', 'NONE')
call NERDTreeHighlightFile('gitconfig', '242', 'none', '#6c6c6c', 'NONE')
call NERDTreeHighlightFile('gitignore', '242', 'none', '#6c6c6c', 'NONE')
