-- lsp auto install
local lsp_installer = require "nvim-lsp-installer"

-- Include the servers you want to have installed by default below
local servers = {
  "tsserver",
  "diagnosticls",
  "graphql",
  "jsonls",
  "sumneko_lua",
}

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found and not server:is_installed() then
    lsp_installer.install(name)
  end
end


local nvim_lsp = require("lspconfig")
local opts = { noremap=true, silent=true }

vim.api.nvim_set_keymap('n', '<Leader>sd', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)

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
  -- vim.cmd(
      -- "command! LspDiagLine lua vim.lsp.diagnostic.open_float()")
  vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_map(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_map(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_map(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_map(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_map(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_map(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_map(bufnr, 'n', '<Leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_map(bufnr, 'n', '<Leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_map(bufnr, 'n', '<Leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_map(bufnr, 'n', '<Leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_map(bufnr, 'n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_map(bufnr, 'n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_map(bufnr, 'n', '<Leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local _, tsserver = lsp_installer.get_server('tsserver')
tsserver:on_ready(function()
  nvim_lsp.tsserver.setup {
    on_attach = on_attach
  }
end)

local _, graphqlserver = lsp_installer.get_server('graphql')
graphqlserver:on_ready(function()
  nvim_lsp.graphql.setup {
    on_attach = on_attach,
    filetypes = { 'typescript', 'javascript' }
  }
end)

local _, jsonlsserver = lsp_installer.get_server('jsonls')
jsonlsserver:on_ready(function()
  nvim_lsp.jsonls.setup {
    on_attach = on_attach
  }
end)

local _, luaserver = lsp_installer.get_server('sumneko_lua')
luaserver:on_ready(function()
  nvim_lsp.sumneko_lua.setup {
    on_attach = on_attach
  }
end)

local _, diagnosticsserver = lsp_installer.get_server('diagnosticls')
diagnosticsserver:on_ready(function()
  local filetypes = {
      json = "eslint",
      javascript = "eslint",
      typescript = "eslint",
      typescriptreact = "eslint",
  }
  -- local linters = {
  --     eslint = {
  --         sourceName = "eslint",
  --         command = this_dir .. "/nvim/node_modules/.bin/eslint_d",
  --         rootPatterns = {".eslintrc.js", "package.json"},
  --         debounce = 100,
  --         args = {"--stdin", "--stdin-filename", "%filepath", "--format", "json"},
  --         parseJson = {
  --             errorsRoot = "[0].messages",
  --             line = "line",
  --             column = "column",
  --             endLine = "endLine",
  --             endColumn = "endColumn",
  --             message = "${message} [${ruleId}]",
  --             security = "severity"
  --         },
  --         securities = {[2] = "error", [1] = "warning"}
  --     }
  -- }
  -- local formatters = {
  --     prettier = {command = this_dir .. "/nvim/node_modules/.bin/prettier", args = {"--stdin-filepath", "%filepath"}}
  -- }
  -- local formatFiletypes = {
  --     json = "prettier",
  --     javascript = "prettier",
  --     typescript = "prettier",
  --     typescriptreact = "prettier"
  -- }

  nvim_lsp.diagnosticls.setup {
      on_attach = on_attach,
      filetypes = vim.tbl_keys(filetypes),
      -- init_options = {
      --     filetypes = filetypes,
      --     linters = linters,
      --     formatters = formatters,
      --     formatFiletypes = formatFiletypes
      -- }
  }
end)



-- lsp config
local this_dir = vim.api.nvim_get_var('this_dir')

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
 vim.lsp.diagnostic.on_publish_diagnostics, {
   -- Enable underline, use default values
   underline = true,
   -- Enable virtual text only on Warning or above, override spacing to 2
   virtual_text = false,
 }
)
-- vim.cmd 'autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()'
--
--
-- local format_async = function(err, _, result, _, bufnr)
--     if err ~= nil or result == nil then return end
--     if not vim.api.nvim_buf_get_option(bufnr, "modified") then
--         local view = vim.fn.winsaveview()
--         vim.lsp.util.apply_text_edits(result, bufnr)
--         vim.fn.winrestview(view)
--         if bufnr == vim.api.nvim_get_current_buf() then
--             vim.api.nvim_command("noautocmd :update")
--         end
--     end
-- end
-- vim.lsp.handlers["textDocument/formatting"] = format_async
-- _G.lsp_organize_imports = function()
--     local params = {
--         command = "_typescript.organizeImports",
--         arguments = {vim.api.nvim_buf_get_name(0)},
--         title = ""
--     }
--     vim.lsp.buf.execute_command(params)
-- end
-- local on_attach = function(client, bufnr)
--     local buf_map = vim.api.nvim_buf_set_keymap
--     vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
--     vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
--     vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
--     vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
--     vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
--     vim.cmd("command! LspOrganize lua lsp_organize_imports()")
--     vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
--     vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
--     vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
--     vim.cmd("command! LspDiagPrev lua vim.lsp.diagnostic.goto_prev()")
--     vim.cmd("command! LspDiagNext lua vim.lsp.diagnostic.goto_next()")
--     vim.cmd(
--         "command! LspDiagLine lua vim.lsp.diagnostic.show_line_diagnostics()")
--     vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
--     buf_map(bufnr, "n", "gd", ":LspDef<CR>", {silent = true})
--     buf_map(bufnr, "n", "<Leader>rn", ":LspRename<CR>", {silent = true})
--     buf_map(bufnr, "n", "gR", ":LspRefs<CR>", {silent = true})
--     buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>", {silent = true})
--     buf_map(bufnr, "n", "K", ":LspHover<CR>", {silent = true})
--     buf_map(bufnr, "n", "gs", ":LspOrganize<CR>", {silent = true})
--     buf_map(bufnr, "n", "[a", ":LspDiagPrev<CR>", {silent = true})
--     buf_map(bufnr, "n", "]a", ":LspDiagNext<CR>", {silent = true})
--     buf_map(bufnr, "n", "ga", ":LspCodeAction<CR>", {silent = true})
--     buf_map(bufnr, "n", "<Leader>a", ":LspDiagLine<CR>", {silent = true})
--     buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>",
--               {silent = true})
--
-- -- remove thids block if autoformatting is not needed
-- if client.resolved_capabilities.document_formatting then
--         vim.api.nvim_exec([[
--          augroup LspAutocommands
--              autocmd! * <buffer>
--              autocmd BufWritePost <buffer> LspFormatting
--          augroup END
--          ]], true)
--     end
-- end


print('plugins config 6')
