autocmd Filetype javascript,typescript call ApplyJsMacros()
function ApplyJsMacros()
  map mf i() => {}i
  map mF o() => {}ki
  map md odebugger;
  map ml oconsole.log();hi
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
