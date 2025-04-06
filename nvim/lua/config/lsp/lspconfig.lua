local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  print("error lspconfig_status")
  return
end

local on_attach = function(_, bufnr)
  local map = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
  end
  map("K", vim.lsp.buf.hover, "Hover Documentation")
  map("H", vim.lsp.buf.signature_help, "Signature Help")
  map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
  map("gR", vim.lsp.buf.references, "[G]oto [R]eferences List")
  -- map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
  -- map("gt", require("telescope.builtin").lsp_type_definitions, "[G]oto [D]efinition")
  map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
  map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  map("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
  map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
  map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
  map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
  map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
end

local servers = {
  "lua_ls",
  "gopls",
  "html",
  "ts_ls",
  "templ",
  "yamlls",
  "protols",
  "tailwindcss",
  "jsonls",
  "graphql",
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities({}, false))

lspconfig.marksman.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
lspconfig.golangci_lint_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
vim.lsp.config("*", { capabilities = capabilities, on_attach = on_attach })
vim.lsp.enable(servers)
vim.diagnostic.config({
  severity_sort = true,
  -- virtual_lines = true,
  -- float = { border = "rounded", source = "if_many" },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = "E",
      [vim.diagnostic.severity.WARN] = "W",
      [vim.diagnostic.severity.INFO] = "I",
      [vim.diagnostic.severity.HINT] = "H",
    },
  } or {},
  virtual_text = {
    source = "if_many",
    spacing = 2,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
})
vim.diagnostic.enable(true)
