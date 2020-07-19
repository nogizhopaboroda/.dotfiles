""Get current directory
if argc() != 0 && isdirectory(argv()[0])
  let g:cwd = argv()[0]
else
  let g:cwd = getcwd()
endif


let s:this_dir = expand("<sfile>:h")

function ImportFile( filename )
  let filePath = s:this_dir . '/' . a:filename
  if filereadable(glob(filePath))
     execute "source " . filePath
  else
    echo 'Could not find file: ' . filePath
  endif
endfunction


call ImportFile('vim/general_settings.vim')
call ImportFile('vim/helpers.vim')
call ImportFile('vim/convert_color.vim')
call ImportFile('vim/plugins.vim')
call ImportFile('vim/highlight_file_type.vim')
call ImportFile('vim/macros.vim')



"" copy to system clipboard
vnoremap <M-c> "+y

"" Alt + ->  -  go to the beginning of the next word
nmap <A-Right> w
imap <A-Right> <C-o>w
"" Alt + ->  -  go to the beginning of the next word
nmap <A-Left> b
imap <A-Left> <C-o>b

"" Alt + ->  -  go to the beginning of the next word
nmap <C-e> $
imap <C-e> <C-o>$
"" Alt + ->  -  go to the beginning of the next word
nmap <C-a> 0
imap <C-a> <C-o>0



cnoreabbrev fp call CopyAndPrintPath('%:p', "true", "false")
cnoreabbrev fpl call CopyAndPrintPath('%:p', "true", "true")
cnoreabbrev fa call CopyAndPrintPath('%:p', "false", "false")
cnoreabbrev fal call CopyAndPrintPath('%:p', "false", "true")
cnoreabbrev fn call CopyAndPrintPath('%:t', "false", "false")
cnoreabbrev fnl call CopyAndPrintPath('%:t', "false", "true")
cnoreabbrev fnn call CopyAndPrintPath('%:r', "false", "false")

cnoreabbrev pcd :execute 'cd ' . cwd

cnoreabbrev presentation call SetFontSize(18)
cnoreabbrev stop_presentation call SetFontSize(11)

"" my keymappings
nmap <silent> <D-A-Up> :wincmd k<CR>
nmap <silent> <D-A-Down> :wincmd j<CR>
nmap <silent> <D-A-Left> :wincmd h<CR>
nmap <silent> <D-A-Right> :wincmd l<CR>

nmap <silent> <C-S-Up> :wincmd k<CR>
nmap <silent> <C-S-Down> :wincmd j<CR>
nmap <silent> <C-S-Left> :wincmd h<CR>
nmap <silent> <C-S-Right> :wincmd l<CR>

nmap <silent> <S-Right> :tabnext<CR>
nmap <silent> <S-Left> :tabprev<CR>

  "" jump to start/end of word by alt-arrow
map f e
map b b
inoremap f <C-o>e
inoremap b <C-o>b

  "" show/hide vertical line
nmap <silent> <leader>v :call ToggleVerticalLine()<CR>
