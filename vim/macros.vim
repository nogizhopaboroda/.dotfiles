autocmd Filetype javascript call ApplyJsMacros()
function ApplyJsMacros()
  map mf afunction(){
  map mF omf
  map mc oif(){
  map mC oif(){
  map md odebugger;
  map ml oconsole.log();hi
  map mr ovar  = require('');^4li
endfunction

autocmd Filetype html call ApplyHtmlMacros()
function ApplyHtmlMacros()
  map md o<div class="">
endfunction

autocmd Filetype css,scss,sass,html call ApplyStylesMacros()
function ApplyStylesMacros()
  map mc o. {
  map mi o# {
  map mt odiv {
  map mm o@media () {
endfunction