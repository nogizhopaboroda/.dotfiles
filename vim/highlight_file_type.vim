" NERDTress File highlighting

"" :XtermColorTable - shows color table

let s:gray = "6c6c6c" """#6c6c6c

let g:NERDTreeExtensionHighlightColor = {}

let g:NERDTreeExtensionHighlightColor['md'] = "5f875f" """#5f875f

let g:NERDTreeExtensionHighlightColor['json'] = "ffff00" """#ffff00
let g:NERDTreeExtensionHighlightColor['js'] = "ff8700" """#ff8700
let g:NERDTreeExtensionHighlightColor['jsx'] = "ffaf00" """#ffaf00

let g:NERDTreeExtensionHighlightColor['ts'] = "afdfff" """#afdfff
let g:NERDTreeExtensionHighlightColor['tsx'] = "afffdf" """#afffdf

let g:NERDTreeExtensionHighlightColor['html'] = "00af5f" """#00af5f

let g:NERDTreeExtensionHighlightColor['css'] = "00ffd7" """#00ffd7

let g:NERDTreeExtensionHighlightColor['php'] = "00ffd7" """#af5f87


let g:NERDTreeExactMatchHighlightColor = {}

let g:NERDTreeExactMatchHighlightColor['.gitconfig'] = s:gray
let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:gray

""" directories
let g:NERDTreeExactMatchHighlightColor['node_modules/'] = s:gray
let g:NERDTreeExactMatchHighlightColor['vendor/'] = s:gray
let g:NERDTreeExactMatchHighlightColor['.git/'] = s:gray
let g:NERDTreeExactMatchHighlightColor['.cache/'] = s:gray
let g:NERDTreeExactMatchHighlightColor['.vagrant/'] = s:gray
let g:NERDTreeExactMatchHighlightColor['public/'] = s:gray
let g:NERDTreeExactMatchHighlightColor['public_html/'] = s:gray
let g:NERDTreeExactMatchHighlightColor['dist/'] = s:gray

let g:NERDTreeExactMatchHighlightColor['test/'] = "00875f" """#00875f
let g:NERDTreeExactMatchHighlightColor['tests/'] = "00875f" """#00875f


let g:NERDTreePatternMatchHighlightColor = {}

