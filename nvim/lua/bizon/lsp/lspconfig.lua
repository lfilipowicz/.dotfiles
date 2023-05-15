local util = require("lspconfig.util")
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

-- enable keybinds only for when lsp server available
local on_attach = function(client)
  -- keybind options
  -- set keybinds
  vim.keymap.set("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
  vim.keymap.set("n", "gR", "<cmd>lua vim.lsp.buf.references()<CR>", opts) -- show definition, references
  vim.keymap.set("n", "gD", "<cmd>Lspsaga goto_definition<CR>", opts) -- got to declaration
  vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<cr>", opts) -- see definition and make edits in window
  vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
  vim.keymap.set("n", "<leader>la", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
  vim.keymap.set("n", "<leader>lr", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
  vim.keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
  vim.keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
  vim.keymap.set("n", "<leader>lk", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
  vim.keymap.set("n", "<leader>lj", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
  vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
  vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>", opts) -- see outline on right hand side
  vim.keymap.set("n", "<leader>vd", "<cmd> lua vim.diagnostic.open_float()<cr>", opts)

  vim.keymap.set("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")
  -- Show buffer diagnostics
  vim.keymap.set("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>", opts)
  -- Show workspace diagnostics
  vim.keymap.set("n", "<leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>", opts)
  -- Show cursor diagnostics
  vim.keymap.set("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
  -- typescript specific keymaps (e.g. rename file and update imports)

  if client.name == "tsserver" then
    vim.keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>", opts) -- rename file and update imports
    vim.keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>", opts) -- organize imports (not in youtube nvim video)
    vim.keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>", opts) -- remove unused variables (not in youtube nvim video)
  end

  if client.name == "rust_analyzer" then
    vim.lsp.codelens.refresh()
    vim.keymap.set("n", "<leader>ra", ":RustHoverActions<CR>", opts) -- rename file and update imports
  end
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
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
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
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
  experimental = {
    classRegex = {
      "clsx\\(([^)]*)\\)",
      "(?:'|\"|`)([^']*)(?:'|\"|`)",
    },
  },
})

-- configure lua server (with special settings)
lspconfig["lua_ls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = { -- custom settings for lua
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      -- make the language server recognize "vim" global
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        -- make language serv fger aware of runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
})

lspconfig["taplo"] = {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- lspconfig.sqlls.setup({ on_attach, capabilities })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "sh",
  callback = function()
    vim.lsp.start({
      name = "bash-language-server",
      cmd = { "bash-language-server", "start" },
    })
  end,
})
lspconfig["phpactor"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    ["language_server_phpstan.enabled"] = false,
    ["language_server_psalm.enabled"] = false,
  },
})

lspconfig["graphql"].setup({
  on_attach,
  capabilities,
  filetypes = { "graphql" },
  root_dir = util.root_pattern(".graphql.config.*", "graphql.config.*"),
})

lspconfig["jsonls"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    json = {
      schemas = {
        {

          fileMatch = { ".eslintrc.json" },
          url = "https://json.schemastore.org/eslintrc.json",
        },
        {
          fileMatch = { "turbo.json" },
          url = "https://turbo.build/schema.json",
        },
        {
          fileMatch = { "composer.json" },
          url = "https://raw.githubusercontent.com/composer/composer/master/res/composer-schema.json",
        },
        {
          fileMatch = { "package.json" },
          url = "https://json.schemastore.org/package.json",
        },
        {
          fileMatch = { "tsconfig.json" },
          url = "https://json.schemastore.org/tsconfig.json",
        },
        {
          fileMatch = { "compile_commands.json" },
          url = "https://json.schemastore.org/compile-commands.json",
        },
        {
          fileMatch = { ".prettierrc" },
          url = "https://json.schemastore.org/prettierrc.json",
        },
        {
          fileMatch = { "deno.json", "deno.jsonc" },
          url = "https://deno.land/x/deno/cli/schemas/config-file.v1.json",
        },
      },
    },
  },
})

lspconfig.yamlls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.diagnostic.config({
  virtual_text = true,
  update_on_insert = true,
  severity_sort = true,
  -- float = {
  --   focusable = false,
  --   style = "minimal",
  --   border = "rounded",
  --   source = "always",
  --   header = "",
  --   prefix = "",
  -- },
})

-- lspconfig["rome"].setup({
--   on_attach = on_attach,
--   capabilities = capabilities,
-- })

local M = {}

M.on_attach = on_attach
M.capabilities = capabilities

return M
