if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif



function s:setupPlugins(installed)
  let isSetup = a:installed

""Interface

  ""Theme
  Plug 'lifepillar/vim-solarized8'
  if isSetup
    set background=dark
    colorscheme solarized8
    let g:solarized_termtrans = 1
  endif

  ""Status line
  Plug 'powerline/fonts'
  Plug 'ryanoasis/vim-devicons'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'bling/vim-airline'
  if isSetup
  "" add red accent
    function! AirlineThemePatch(palette)
      let a:palette.accents.bold_red = [  '#ff0000' , '' , RGB('#ff0000') , '', 'bold'   ]
      let a:palette.accents.gray = [  '#444444' , '' , RGB('#444444') , '', ''   ]
    endfunction
    let g:airline_theme_patch_func = 'AirlineThemePatch'
    call airline#highlighter#add_accent('bold_red')
    call airline#highlighter#add_accent('gray')

    let g:airline_powerline_fonts = 1
    let g:airline_theme           = 'powerlineish'

    let g:airline#extensions#whitespace#enabled = 0 "disable whitespace plugin

    let g:airline_section_y = ''
    let g:webdevicons_enable_airline_statusline_fileformat_symbols = 0

    let g:airline_section_b = airline#section#create(['%{get(g:,"coc_git_status","")}', '%{get(b:,"coc_git_status","")}'])

    call airline#parts#define('directory', {
              \ 'raw': '%{GetPath("%:p:h", "true", "false")}/',
              \ 'accent': 'gray',
              \ })
    call airline#parts#define('file', {
              \ 'raw': '%f '
              \ })
    call airline#parts#define('change_sign', {
              \ 'raw': '%m',
              \ 'accent': 'red',
              \ })
    call airline#parts#define('readonly', {
              \ 'raw': '%{airline#util#wrap(airline#parts#readonly(),0)}',
              \ 'accent': 'red',
              \ })

    let g:airline_section_c = airline#section#create(['directory', 'file', 'change_sign', 'readonly'])

    let g:airline#extensions#hunks#non_zero_only = 1

    " vim-powerline symbols
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    let g:airline_left_sep = ''
    let g:airline_right_sep = ''
    let g:airline_symbols.linenr = ''
    let g:airline_symbols.branch = '⎇'
    let g:airline_symbols.paste = 'ρ'
    let g:airline_symbols.whitespace = 'Ξ'

    let g:airline_mode_map = {
          \ '__' : '-',
          \ 'n'  : 'N',
          \ 'i'  : 'I',
          \ 'R'  : 'R',
          \ 'c'  : 'C',
          \ 'v'  : 'V',
          \ 'V'  : 'V',
          \ 's'  : 'S',
          \ 'S'  : 'S',
          \ }
  endif

  Plug 'jeffkreeftmeijer/vim-numbertoggle'


  ""Tabs
  Plug 'gcmt/taboo.vim'
  if isSetup
    let g:taboo_tab_format = '%P/%f %m'
  endif

  ""Search
    ""Project search
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    if isSetup
      command! -bang -nargs=* Search
        \ call fzf#vim#grep(
        \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
        \   <bang>0 ? fzf#vim#with_preview('up:60%')
        \           : fzf#vim#with_preview('right:50%:hidden', '?'),
        \   <bang>0)

      command! -bang -nargs=? -complete=dir Files
        \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', 'cat {}']}, <bang>0)

      command! -bang -nargs=? -complete=dir GFiles
        \ call fzf#vim#gitfiles(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', 'cat {}']}, <bang>0)


      nnoremap <space>/ :execute 'Search ' . input('Search string: ')<cr>
      nnoremap <C-p> :GFiles<cr>
    endif
    "
    ""File search
    Plug 'henrik/vim-indexed-search'
    if isSetup
      let g:indexed_search_shortmess = 1
      let g:indexed_search_numbered_only = 1
    endif

  ""Rainbow brackets
  Plug 'luochen1990/rainbow'
  if isSetup
    let g:rainbow_conf = {
        \   'guifgs': ['#CDDC39', '#FF5252', '#FF9800', '#4CAF50', '#E91E63'],
        \   'ctermfgs': [RGB('#CDDC39'), RGB('#FF5252'), RGB('#FF9800'), RGB('#4CAF50'), RGB('#E91E63')],
        \   'operators': '_,_',
        \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
        \   'separately': {
        \       '*': {},
        \       'vim': {
        \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
        \       },
        \       'html': 0,
        \   }
        \}

    let g:rainbow_active = 1
  endif

  ""Multiple cursors
  Plug 'mg979/vim-visual-multi'

  ""Highlight whitespaces
  Plug 'ntpeters/vim-better-whitespace'

  ""Highlight uses of the current word under the cursor
  Plug 'RRethy/vim-illuminate'
  if isSetup
    let g:Illuminate_highlightUnderCursor = 0
  endif


""Linting/Formatting
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  if isSetup
    let g:coc_config_home = '~/.dotfiles/vim'
    let g:coc_global_extensions = [
      \ 'coc-json',
      \ 'coc-html',
      \ 'coc-yaml',
      \ 'coc-styled-components',
      \ 'coc-vimlsp',
      \ 'coc-sh',
      \ 'coc-docker',
      \ 'coc-go',
      \ 'coc-eslint',
      \ 'coc-tsserver',
      \ 'coc-prettier',
      \ 'coc-highlight',
      \ 'coc-explorer',
      \ 'coc-pairs',
      \ 'coc-git',
    \]

    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gr <Plug>(coc-references)

    nmap <leader>p  :CocCommand prettier.formatFile<cr>

    exe "hi CocErrorSign  ctermfg=".RGB('#FF5252')." guifg=#FF5252"

    let g:loaded_netrw = 1
    nmap <silent> <Leader>f :CocCommand explorer<CR>
    autocmd VimEnter * if !argc() | exe 'CocCommand explorer' | endif
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) | exe 'CocCommand explorer ' . g:cwd | endif

    autocmd FileType markdown let b:coc_pairs_disabled = ['`']

    exe "highlight DiffAdd ctermbg=NONE guibg=NONE ctermfg=".RGB('#05aff7')." guifg=#05aff7 cterm=NONE gui=NONE"
    exe "highlight DiffDelete ctermbg=NONE guibg=NONE ctermfg=".RGB('#cb4b16')." guifg=#cb4b16 cterm=NONE gui=NONE"
    exe "highlight DiffTopDelete ctermbg=NONE guibg=NONE ctermfg=".RGB('#cb4b16')." guifg=#cb4b16 cterm=NONE gui=NONE"
    exe "highlight DiffChange ctermbg=NONE guibg=NONE ctermfg=".RGB('#fcba03')." guifg=#fcba03 cterm=NONE gui=NONE"
    exe "highlight DiffChangeDelete ctermbg=NONE guibg=NONE ctermfg=".RGB('#FF9800')." guifg=#FF9800 cterm=NONE gui=NONE"

    nmap [c <Plug>(coc-git-prevchunk)
    nmap ]c <Plug>(coc-git-nextchunk)

  endif


""Syntax
  Plug 'sheerun/vim-polyglot'


  Plug 'Quramy/vim-js-pretty-template'
  if isSetup
    call jspretmpl#register_tag('gql', 'graphql')
    call jspretmpl#register_tag('html', 'html')
    call jspretmpl#register_tag('css', 'css')
    autocmd FileType javascript,typescript JsPreTmpl
  endif

  Plug 'glanotte/vim-jasmine'
  if isSetup
    autocmd BufReadPost,BufNewFile *test.js set filetype=jasmine.javascript syntax=jasmine.javascript
    autocmd BufReadPost,BufNewFile *test.ts set filetype=jasmine.typescript syntax=jasmine.typescript
  endif

  Plug 'FabioAntunes/vim-node'
  if isSetup
    autocmd FileType javascript,json,typescript nmap <buffer> <C-w>gf <Plug>NodeGotoFile
    autocmd FileType javascript,json,typescript nmap <buffer> gf <Plug>NodeTabGotoFile
  endif


  Plug 'Valloric/MatchTagAlways'
  if isSetup
    nnoremap <leader>% :MtaJumpToOtherTag<cr>
  endif



""Editing
  Plug 'scrooloose/nerdcommenter'
  if isSetup
    let g:NERDCustomDelimiters = {
        \ 'blade': {  'left': '{{-- ', 'right': ' --}}', 'leftAlt': '{{-- ','rightAlt': ' --}}' },
        \ 'scss': {  'left': '/* ', 'right': ' */', 'leftAlt': '/* ','rightAlt': ' */' },
    \}
    " Add spaces after comment delimiters by default
    let g:NERDSpaceDelims = 1
    " Enable trimming of trailing whitespace when uncommenting
    let g:NERDTrimTrailingWhitespace = 1
  endif

  Plug 'idanarye/vim-casetrate'
  if isSetup
    let g:casetrate_leader = '\t'
  endif

  Plug 'tpope/vim-surround'
  Plug 't9md/vim-surround_custom_mapping'
  if isSetup
    let g:surround_custom_mapping = {}
    let g:surround_custom_mapping.javascript = {
        \ 'f':  "function(){ \r }",
        \ 't':  "try { \r } catch(e) {}",
        \ 'i':  "if(){ \r }"
        \ }
    let g:surround_custom_mapping.scss = {
        \ '.':  ". { \r }",
        \ '#':  "# { \r }"
        \ }
    let g:surround_custom_mapping.css = {
        \ '.':  ". { \r }",
        \ '#':  "# { \r }"
        \ }
  endif

  Plug 'tpope/vim-repeat'

  Plug 'benjifisher/matchit.zip'


  ""Git
  Plug 'tpope/vim-fugitive'
  Plug 'gregsexton/gitv'
  Plug 'zivyangll/git-blame.vim'
  Plug 'junegunn/gv.vim'


  ""Misc
  Plug 'guns/xterm-color-table.vim'
  Plug 'tmux-plugins/vim-tmux-focus-events'

endfunction


call plug#begin('~/.vim/plugged')
  call s:setupPlugins(0)
call plug#end()

autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

call s:setupPlugins(1)
