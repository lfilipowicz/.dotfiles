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
local on_attach = function(client, bufnr)
  -- keybind options
  -- set keybinds
  vim.keymap.set("n", "gr", "<cmd>Lspsaga finder ref+def<CR>", opts) -- show definition, references
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
  vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
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

lspconfig["rust_analyzer"].setup({

  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "rust" },
  root_dir = util.root_pattern("Cargo.toml"),
})

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
    settings = {
      -- specify some or all of the following settings if you want to adjust the default behavior
      javascript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
        },
      },
      typescript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
        },
      },
    },
  },
})

-- configure css server
lspconfig["cssls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig["eslint"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- configure tailwindcss server
lspconfig["tailwindcss"].setup({
  capabilities = capabilities,
  filetypes = {
    "css",
    "scss",
    "sass",
    "postcss",
    "html",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "svelte",
    "templ",
  },
  on_attach = on_attach,
  settings = {
    includeLanguages = { templ = "html" },
  },
  init_options = {
    userLanguages = {
      templ = "html",
    },
  },
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
  inlay_hint = { enable = true },
  settings = { -- custom settings for lua
    Lua = {
      runtime = { version = "LuaJIT" },
      hint = { enable = true },
      completion = {
        callSnippet = "Replace",
      },
      -- make the language server recognize "vim" global
      workspace = {
        checkThirdParty = false,
        -- make language serv fger aware of runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
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
  filetypes = { "typescript", "typescriptreact", "graphql" },
  root_dir = util.root_pattern(".git", ".graphqlrc*", ".graphql.config.*", "graphql.config.*"),
})

lspconfig["jsonls"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    json = {
      schemas = {
        {
          fileMatch = { "(*.schema.json" },
          url = "https://json-schema.org/draft/2019-09/schema",
        },
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

-- setup your lsp servers as usual

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

lspconfig.gopls.setup({

  on_attach = on_attach,
  capabilities = capabilities,
  cms = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern({ "go.work", "go.mod", ".git" }),
  settings = {
    gopls = {
      gofumpt = true,
      codelenses = {
        gc_details = false,
        generate = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      analyses = {
        fieldalignment = true,
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
      },
      usePlaceholders = true,
      completeUnimported = true,
      staticcheck = true,
      directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
      semanticTokens = true,
    },
  },
})

lspconfig.templ.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.htmx.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html", "templ" },
})

local M = {}

M.on_attach = on_attach
M.capabilities = capabilities

return M
