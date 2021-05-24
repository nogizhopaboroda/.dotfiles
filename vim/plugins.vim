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
    let g:solarized_termtrans = 1
    colorscheme solarized8
    set background=dark
  endif

  Plug 'ryanoasis/vim-devicons'

  ""Status line
  Plug 'itchyny/lightline.vim'
  if isSetup
    let g:lightline = {
      \ 'component': {
      \   'lineinfo': '%3p%% %3l/%{line("$")}:%-2c',
      \   'filename': '%#StatusDirectoryColor# %{GetPath("%:p:h", "true", "false")}/%#NormalColor#%t ',
      \   'modified': '%#ChangedSignColor#%{&modifiable && &modified ? "[+]" : ""} ',
      \   'git_status': '%#GitStatusColor# %{get(g:,"coc_git_status","")} %{get(b:,"coc_git_status","")}',
      \   'linter_status':
      \     '%#LinterErrorsCountColor#%{GetLinterStatus("error", " E:")}' .
      \     '%#LinterWarningsCountColor#%{GetLinterStatus("warning", "  W:")}' .
      \     '%#LinterInfoCountColor#%{GetLinterStatus("information", "  I:")}'
      \ },
      \ 'component_type': { 'filename': 'raw', 'modified': 'raw', 'git_status': 'raw', 'linter_status': 'raw' },
      \ 'active': {
      \   'left': [ [ 'mode' ],
      \             [ 'git_status' ],
      \             [ 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo', 'linter_status' ],
      \              [ 'filetype' ] ]
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
    \ }

    function! GetLinterStatus(type, prefix) abort
      let info = get(b:, 'coc_diagnostic_info', {})
      if empty(info) | return '' | endif
      if get(info, a:type, 0)
        return a:prefix . info[a:type] . ' '
      endif
      return ''
    endfunction

    let g:lightline.colorscheme = 'powerlineish'
    let g:lightline.mode_map = {
      \ 'n'  : 'N',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'c'  : 'C',
      \ 'v'  : 'V',
      \ 's'  : 'S',
      \ 'V' : 'V-LINE',
      \ "\<C-v>": 'V-BLOCK',
      \ 'S' : 'S-LINE',
      \ "\<C-s>": 'S-BLOCK',
      \ 't': 'TERMINAL',
    \ }

    let s:palette = g:lightline#colorscheme#{g:lightline.colorscheme}#palette
    let s:right_colors = s:palette.normal.right
    let s:middle_colors = s:palette.normal.middle[0]
    exe printf('hi StatusDirectoryColor ctermfg=%d guifg=%s ctermbg=%d guibg=%s',
      \ RGB('#444444'), '#444444', s:middle_colors[3], s:middle_colors[1])
    exe printf('hi NormalColor ctermfg=%d guifg=%s ctermbg=%d guibg=%s',
      \ s:middle_colors[2], s:middle_colors[0], s:middle_colors[3], s:middle_colors[1])
    exe printf('hi ChangedSignColor ctermfg=%d guifg=%s ctermbg=%d guibg=%s',
      \ RGB('#ff0000'), '#ff0000', s:middle_colors[3], s:middle_colors[1])
    exe printf('hi GitStatusColor ctermfg=%d guifg=%s ctermbg=%d guibg=%s',
      \ s:right_colors[0][2], s:right_colors[0][0], s:right_colors[0][3], s:right_colors[0][1])
    exe printf('hi LinterErrorsCountColor ctermfg=%d guifg=%s ctermbg=%d guibg=%s',
      \ RGB('#000000'), '#000000', RGB('#ff0000'), '#ff0000')
    exe printf('hi LinterWarningsCountColor ctermfg=%d guifg=%s ctermbg=%d guibg=%s',
      \ RGB('#000000'), '#000000', RGB('#fcba03'), '#fcba03')
    exe printf('hi LinterInfoCountColor ctermfg=%d guifg=%s ctermbg=%d guibg=%s',
      \ RGB('#ffffff'), '#ffffff', RGB('#05a9f5'), '#05a9f5')
  endif

  Plug 'jeffkreeftmeijer/vim-numbertoggle'


  ""Tabs
  Plug 'gcmt/taboo.vim'
  if isSetup
    function ProcessPath(path)
      let relative_path = substitute(a:path, g:cwd . "/\\?", "", "")
      let path_segments = split(relative_path, "/")
      if len(path_segments) > 1
        let last_segments = path_segments[-2:-1]
        return join(last_segments, "/")
      else
        return relative_path
      endif
    endfunction
    let g:taboo_tab_format = '%{ProcessPath("%r")} %m'
  endif

  ""Search
    ""Project search
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    if isSetup

      let s:fzfViewOptions = ['--cycle', '--info=inline']

      command! -bang -nargs=? -complete=dir Files
        \ call fzf#vim#files(<q-args>, {'options': s:fzfViewOptions + ['--preview', 'cat {}']}, <bang>0)

      command! -bang -nargs=? -complete=dir GFiles
        \ call fzf#vim#gitfiles(<q-args>, {'options': s:fzfViewOptions + ['--preview', 'cat {}']}, <bang>0)


      function! RipgrepFzf(query, preview)
        let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s'
        let initial_command = printf(command_fmt, fzf#shellescape(a:query))
        let spec = {'options': s:fzfViewOptions, 'dir': g:cwd}
        call fzf#vim#grep(
          \ initial_command, 1,
          \   a:preview ? fzf#vim#with_preview(spec, 'up:60%')
          \             : fzf#vim#with_preview(spec, 'right:50%:hidden', '?'),
          \ a:preview)
      endfunction
      command! -nargs=* -bang Search call RipgrepFzf(<q-args>, <bang>0)

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
  if isSetup
    let g:VM_maps = {}
    let g:VM_maps['Select l'] = ''
    let g:VM_maps['Select h'] = ''
  endif

  ""Highlight whitespaces
  Plug 'ntpeters/vim-better-whitespace'

  ""Highlight uses of the current word under the cursor
  Plug 'RRethy/vim-illuminate'
  if isSetup
    let g:Illuminate_highlightUnderCursor = 0
  endif

  ""Show inline commit info
  Plug 'tveskag/nvim-blame-line'
  if isSetup
    let g:blameLineVirtualTextFormat = '  // %s'
    let g:blameLineGitFormat = '%h, %an, %ar, %s'
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
      \ 'coc-snippets',
    \]

    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gr <Plug>(coc-references)

    nmap <leader>rn <Plug>(coc-rename)

    nmap [l <Plug>(coc-diagnostic-prev)
    nmap ]l <Plug>(coc-diagnostic-next)

    nmap [c <Plug>(coc-git-prevchunk)
    nmap ]c <Plug>(coc-git-nextchunk)

    nmap <leader>p  :CocCommand prettier.formatFile<cr>
    nmap <leader>st :call CocActionAsync('doHover')<cr>

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

  endif

  Plug 'honza/vim-snippets'

""Syntax
  Plug 'sheerun/vim-polyglot'
  if isSetup
    autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
    autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
  endif

  Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

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

  ""Markdown preview
  " Plug 'npxbr/glow.nvim', {'do': ':GlowInstall'}

endfunction


call plug#begin('~/.vim/plugged')
  call s:setupPlugins(0)
call plug#end()

autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

call s:setupPlugins(1)
