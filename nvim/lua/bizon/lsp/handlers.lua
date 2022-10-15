local M = {}

-- TODO: backfill this to template
M.setup = function()
  -- local signs = {
  --   {
  --     name = "DiagnosticSignError",
  --     text = "",
  --   },
  --   {
  --     name = "DiagnosticSignWarn",
  --     text = "",
  --   },
  --   {
  --     name = "DiagnosticSignHint",
  --     text = "",
  --   },
  --   {
  --     name = "DiagnosticSignInfo",
  --     text = "",
  --   },
  -- }

  -- for _, sign in ipairs(signs) do
  --   vim.fn.sign_define(sign.name, {
  --     texthl = sign.name,
  --     text = sign.text,
  --     numhl = "",
  --   })
  -- end

  local config = {
    -- disable virtual text
    -- virtual_text = false,
    -- show signs
    -- signs = {
    --   active = signs,
    -- },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end
local function lsp_highlight_document(client)
  -- if client.server_capabilities.document_highlight then
  local status_ok, illuminate = pcall(require, "illuminate")
  if not status_ok then
    return
  end
  illuminate.on_attach(client)
  -- end
end

local function attach_navic(client, bufnr)
  local status_ok, navic = pcall(require, "nvim-navic")
  if not status_ok then
    return
  end
  navic.attach(client, bufnr)
end

local opts = { noremap = true, silent = true }
local function n_set_buf_keymap(bufnr, keymap, cmd)
  vim.api.nvim_buf_set_keymap(bufnr, "n", keymap, cmd, opts)
end

local function i_set_buf_keymap(bufnr, keymap, cmd)
  vim.api.nvim_buf_set_keymap(bufnr, "i", keymap, cmd, opts)
end

local function lsp_keymaps(bufnr)
  n_set_buf_keymap(bufnr, "gd", "<cmd> lua vim.lsp.buf.definition()<cr>")
  n_set_buf_keymap(bufnr, "gtd", "<cmd> lua vim.lsp.buf.type_definition()<cr>")
  n_set_buf_keymap(bufnr, "gD", "<cmd> lua vim.lsp.buf.declaration()<cr>")
  n_set_buf_keymap(bufnr, "gi", "<cmd> lua vim.lsp.buf.implementation()<cr>")
  n_set_buf_keymap(bufnr, "K", "<cmd>Lspsaga hover_doc<cr>")
  n_set_buf_keymap(bufnr, "<leader>vd", "<cmd> lua vim.diagnostic.open_float()<cr>")
  n_set_buf_keymap(bufnr, "<leader>q", "<cmd> lua vim.diagnostic.setloclist()<cr>")
  i_set_buf_keymap(bufnr, "<C-h>", "<cmd> lua vim.lsp.buf.signature_help()<cr>")
  -- nnoremap("<leader>vws", function()
  --     vim.lsp.buf.workspace_symbol()
  -- end)
  -- nnoremap("<leader>vd", function()
  --     vim.diagnostic.open_float()
  -- end)
  -- nnoremap("[d", function()
  --     vim.diagnostic.goto_next()
  -- end)
  -- nnoremap("]d", function()
  --     vim.diagnostic.goto_prev()
  -- end)
  -- nnoremap("<leader>vca", function()
  --     vim.lsp.buf.code_action()
  -- end)
  -- nnoremap("<leader>vrn", function()
  --     vim.lsp.buf.rename()
  -- end)
  -- inoremap("<C-h>", function()
  --     vim.lsp.buf.signature_help()
  -- end)
  vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format()' ]])
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
  attach_navic(client, bufnr)
  -- if client.name == "tsserver" then
  --   -- client.server_capabilities.documentFormattingProvider = false
  -- end
  -- if client.name == "sumneko_lua" then
  --   attach_navic(client, bufnr)
  --   -- client.server_capabilities.documentFormattingProvider = false
  -- end
  -- if client.name == "jsonls" then
  --   client.server_capabilities.documentFormattingProvider = false
  -- end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true


local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M
