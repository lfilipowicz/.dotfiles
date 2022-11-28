-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  print("error lspconfig_status")
  return
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
  print("error cmp_nvim_lsp_status")
  return
end

-- import typescript plugin safely
local typescript_setup, typescript = pcall(require, "typescript")
if not typescript_setup then
  print("error typescript")
  return
end
local opts = { noremap = true, silent = true }
local function n_set_buf_keymap(bufnr, keymap, cmd)
  vim.api.nvim_buf_set_keymap(bufnr, "n", keymap, cmd, opts)
end
-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
  -- keybind options

  -- set keybinds
  n_set_buf_keymap(bufnr, "gr", "<cmd>Lspsaga lsp_finder<CR>") -- show definition, references
  n_set_buf_keymap(bufnr, "gD", "<cmd>lua vim.lsp.buf.definition()<CR>") -- got to declaration
  n_set_buf_keymap(bufnr, "gd", "<cmd>Lspsaga peek_definition<CR>") -- see definition and make edits in window
  n_set_buf_keymap(bufnr, "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>") -- go to implementation
  n_set_buf_keymap(bufnr, "<leader>la", "<cmd>Lspsaga code_action<CR>") -- see available code actions
  n_set_buf_keymap(bufnr, "<leader>lr", "<cmd>Lspsaga rename<CR>") -- smart rename
  n_set_buf_keymap(bufnr, "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>") -- show  diagnostics for line
  n_set_buf_keymap(bufnr, "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>") -- show diagnostics for cursor
  n_set_buf_keymap(bufnr, "<leader>lk", "<cmd>Lspsaga diagnostic_jump_prev<CR>") -- jump to previous diagnostic in buffer
  n_set_buf_keymap(bufnr, "<leader>lj", "<cmd>Lspsaga diagnostic_jump_next<CR>") -- jump to next diagnostic in buffer
  n_set_buf_keymap(bufnr, "K", "<cmd>Lspsaga hover_doc<CR>") -- show documentation for what is under cursor
  n_set_buf_keymap(bufnr, "<leader>o", "<cmd>LSoutlineToggle<CR>") -- see outline on right hand side
  n_set_buf_keymap(bufnr, "<leader>vd", "<cmd> lua vim.diagnostic.open_float()<cr>")

  -- typescript specific keymaps (e.g. rename file and update imports)
  if client.name == "tsserver" then
    n_set_buf_keymap(bufnr, "<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports
    n_set_buf_keymap(bufnr, "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports (not in youtube nvim video)
    n_set_buf_keymap(bufnr, "<leader>ru", ":TypescriptRemoveUnused<CR>") -- remove unused variables (not in youtube nvim video)
  end
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- configure html server
lspconfig["html"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- configure typescript server with plugin
typescript.setup({
  server = {
    capabilities = capabilities,
    on_attach = on_attach,
  },
})

-- configure css server
lspconfig["cssls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- configure tailwindcss server
lspconfig["tailwindcss"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- configure lua server (with special settings)
lspconfig["sumneko_lua"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = { -- custom settings for lua
    Lua = {
      -- make the language server recognize "vim" global
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        -- make language server aware of runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
})

lspconfig["rust_analyzer"].setup({
  cmd = { "rustup", "run", "nightly", "rust-analyzer" },
  capabilities = capabilities,
  on_attach = on_attach,
})

-- lspconfig["graphql"].setup({
--   on_attach,
--   capabilities,
-- })

local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = on_attach,
  },
})

vim.diagnostic.config({
  update_on_insert = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})
