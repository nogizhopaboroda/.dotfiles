let g:cwd = getcwd()

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

function SetFontSize( size )
  let &guifont = substitute(&guifont, ':h\d\+$', ':h'.a:size, '')
endfunction
