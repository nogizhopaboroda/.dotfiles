local this_dir = vim.api.nvim_get_var('this_dir')

-- Install packer
local execute = vim.api.nvim_command

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '.. install_path)
end

vim.api.nvim_exec([[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]], false)


local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use {'neovim/nvim-lspconfig', run = 'cd ' .. this_dir .. '/nvim && yarn install'}

  use 'folke/lsp-colors.nvim'
  use 'hrsh7th/nvim-compe'           -- Autocompletion plugin
  use 'ishan9299/nvim-solarized-lua'

  use 'kyazdani42/nvim-web-devicons'
  use 'kyazdani42/nvim-tree.lua'

  -- Post-install/update hook with neovim command
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }

  -- use 'tpope/vim-fugitive'           -- Git commands in nvim
  -- use 'tpope/vim-rhubarb'            -- Fugitive-companion to interact with github
  -- use 'tpope/vim-commentary'         -- "gc" to comment visual regions/lines
  -- use 'ludovicchabant/vim-gutentags' -- Automatic tags management
  -- -- UI to select things (files, grep results, open buffers...)
  -- use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}} }
  -- use 'joshdick/onedark.vim'         -- Theme inspired by Atom
  -- use 'itchyny/lightline.vim'        -- Fancier statusline
  -- -- Add indentation guides even on blank lines
  -- use { 'lukas-reineke/indent-blankline.nvim', branch="lua" }
end)

-- color scheme
vim.g.solarized_termtrans = 1
vim.g.solarized_italics = 1
vim.cmd('colorscheme solarized')

-- files tree
vim.api.nvim_set_var('nvim_tree_auto_open', 1)
vim.api.nvim_set_var('nvim_tree_auto_close', 1)
vim.api.nvim_set_var('nvim_tree_ignore', { '.git', 'node_modules', '.cache', 'dist' })

-- gitsigns
require('gitsigns').setup {
  signs = {
    add          = {hl = 'DiffAdd'   , text = '▍'},
    change       = {hl = 'DiffChange', text = '▍'},
    delete       = {hl = 'DiffDelete', text = '▁'},
    topdelete    = {hl = 'DiffDelete', text = '▔'},
    changedelete = {hl = 'DiffChangeDelete', text = '▞'},
  },
}

vim.cmd("highlight DiffAdd ctermbg=NONE guibg=NONE ctermfg=" .. vim.api.nvim_eval("RGB('#05aff7')") .. " guifg=#05aff7 cterm=NONE gui=NONE")
vim.cmd("highlight DiffDelete ctermbg=NONE guibg=NONE ctermfg=" .. vim.api.nvim_eval("RGB('#cb4b16')") .. " guifg=#cb4b16 cterm=NONE gui=NONE")
vim.cmd("highlight DiffTopDelete ctermbg=NONE guibg=NONE ctermfg=" .. vim.api.nvim_eval("RGB('#cb4b16')") .. " guifg=#cb4b16 cterm=NONE gui=NONE")
vim.cmd("highlight DiffChange ctermbg=NONE guibg=NONE ctermfg=" .. vim.api.nvim_eval("RGB('#fcba03')") .. " guifg=#fcba03 cterm=NONE gui=NONE")
vim.cmd("highlight DiffChangeDelete ctermbg=NONE guibg=NONE ctermfg=" .. vim.api.nvim_eval("RGB('#ff9800')") .. " guifg=#ff9800 cterm=NONE gui=NONE")


-- use .ts snippets in .tsx files
vim.g.vsnip_filetypes = {
    typescriptreact = {"typescript"}
}
require"compe".setup {
    preselect = "always",
    source = {
        path = true,
        buffer = true,
        vsnip = true,
        nvim_lsp = true,
        nvim_lua = true
    }
}
local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end
_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return vim.fn["compe#confirm"]()
    elseif vim.fn.call("vsnip#available", {1}) == 1 then
        return t("<Plug>(vsnip-expand-or-jump)")
    else
        return t("<Tab>")
    end
end
vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()",
                        {expr = true, silent = true})
vim.api.nvim_set_keymap("i", "<CR>", [[compe#confirm("<CR>")]],
                        {expr = true, silent = true})
vim.api.nvim_set_keymap("i", "<C-e>", [[compe#close("<C-e>")]],
                        {expr = true, silent = true})



-- lsp

require("lsp-colors").setup({
  Error = "#db4b4b",
  Warning = "#e0af68",
  Information = "#0db9d7",
  Hint = "#10B981"
})


vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
 vim.lsp.diagnostic.on_publish_diagnostics, {
   -- Enable underline, use default values
   underline = true,
   -- Enable virtual text only on Warning or above, override spacing to 2
   virtual_text = false,
 }
)
vim.cmd 'autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()'


local nvim_lsp = require("lspconfig")
local format_async = function(err, _, result, _, bufnr)
    if err ~= nil or result == nil then return end
    if not vim.api.nvim_buf_get_option(bufnr, "modified") then
        local view = vim.fn.winsaveview()
        vim.lsp.util.apply_text_edits(result, bufnr)
        vim.fn.winrestview(view)
        if bufnr == vim.api.nvim_get_current_buf() then
            vim.api.nvim_command("noautocmd :update")
        end
    end
end
vim.lsp.handlers["textDocument/formatting"] = format_async
_G.lsp_organize_imports = function()
    local params = {
        command = "_typescript.organizeImports",
        arguments = {vim.api.nvim_buf_get_name(0)},
        title = ""
    }
    vim.lsp.buf.execute_command(params)
end
local on_attach = function(client, bufnr)
    local buf_map = vim.api.nvim_buf_set_keymap
    vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
    vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
    vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
    vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
    vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
    vim.cmd("command! LspOrganize lua lsp_organize_imports()")
    vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
    vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
    vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
    vim.cmd("command! LspDiagPrev lua vim.lsp.diagnostic.goto_prev()")
    vim.cmd("command! LspDiagNext lua vim.lsp.diagnostic.goto_next()")
    vim.cmd(
        "command! LspDiagLine lua vim.lsp.diagnostic.show_line_diagnostics()")
    vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
buf_map(bufnr, "n", "gd", ":LspDef<CR>", {silent = true})
    buf_map(bufnr, "n", "gr", ":LspRename<CR>", {silent = true})
    buf_map(bufnr, "n", "gR", ":LspRefs<CR>", {silent = true})
    buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>", {silent = true})
    buf_map(bufnr, "n", "K", ":LspHover<CR>", {silent = true})
    buf_map(bufnr, "n", "gs", ":LspOrganize<CR>", {silent = true})
    buf_map(bufnr, "n", "[a", ":LspDiagPrev<CR>", {silent = true})
    buf_map(bufnr, "n", "]a", ":LspDiagNext<CR>", {silent = true})
    buf_map(bufnr, "n", "ga", ":LspCodeAction<CR>", {silent = true})
    buf_map(bufnr, "n", "<Leader>a", ":LspDiagLine<CR>", {silent = true})
    buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>",
              {silent = true})

-- remove thids block if autoformatting is not needed
if client.resolved_capabilities.document_formatting then
        vim.api.nvim_exec([[
         augroup LspAutocommands
             autocmd! * <buffer>
             autocmd BufWritePost <buffer> LspFormatting
         augroup END
         ]], true)
    end
end
nvim_lsp.tsserver.setup {
    cmd = {this_dir .. '/nvim/node_modules/.bin/typescript-language-server', '--stdio'},
    on_attach = function(client)
        client.resolved_capabilities.document_formatting = false
        on_attach(client)
    end
}
local filetypes = {
    typescript = "eslint",
    typescriptreact = "eslint",
}
local linters = {
    eslint = {
        sourceName = "eslint",
        command = this_dir .. "/nvim/node_modules/.bin/eslint_d",
        rootPatterns = {".eslintrc.js", "package.json"},
        debounce = 100,
        args = {"--stdin", "--stdin-filename", "%filepath", "--format", "json"},
        parseJson = {
            errorsRoot = "[0].messages",
            line = "line",
            column = "column",
            endLine = "endLine",
            endColumn = "endColumn",
            message = "${message} [${ruleId}]",
            security = "severity"
        },
        securities = {[2] = "error", [1] = "warning"}
    }
}
local formatters = {
    prettier = {command = this_dir .. "/nvim/node_modules/.bin/prettier", args = {"--stdin-filepath", "%filepath"}}
}
local formatFiletypes = {
    typescript = "prettier",
    typescriptreact = "prettier"
}
nvim_lsp.diagnosticls.setup {
    cmd = {this_dir .. '/nvim/node_modules/.bin/diagnostic-languageserver', '--stdio'},
    on_attach = on_attach,
    filetypes = vim.tbl_keys(filetypes),
    init_options = {
        filetypes = filetypes,
        linters = linters,
        formatters = formatters,
        formatFiletypes = formatFiletypes
    }
}

