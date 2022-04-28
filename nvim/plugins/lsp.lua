-- lsp auto install
local lsp_installer = require "nvim-lsp-installer"

-- Include the servers you want to have installed by default below
local servers = {
  "tsserver",
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
--
-- vim.lsp.handlers["textDocument/formatting"] = format_async
-- _G.lsp_organize_imports = function()
--     local params = {
--         command = "_typescript.organizeImports",
--         arguments = {vim.api.nvim_buf_get_name(0)},
--         title = ""
--     }
--     vim.lsp.buf.execute_command(params)
-- end


print('plugins config 7')
