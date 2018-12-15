autocmd Filetype javascript call ApplyJsMacros()
function ApplyJsMacros()
  map mf afunction(){}ki
  map mF omf
  map mc oif(){}k3li
  map mC oif(){} else {}2k3li
  map md odebugger;
  map ml oconsole.log();hi
  map mr ovar  = require('');^4li
endfunction

autocmd Filetype html call ApplyHtmlMacros()
function ApplyHtmlMacros()
  map md o<div class=""></div>ki
endfunction

autocmd Filetype css,scss,sass,html call ApplyStylesMacros()
function ApplyStylesMacros()
  map mc o. {}ka
  map mi o# {}ka
  map mt odiv {}k3li
  map mm o@media () {}k8li
endfunction

autocmd Filetype python call ApplyPythonMacros()
function ApplyPythonMacros()
  map md opdb.set_trace()
endfunction
