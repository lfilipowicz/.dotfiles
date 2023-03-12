--require("mason").setup()
--require("mason-lspconfig").setup({
--  ensure_installed = { "sumneko_lua", "rust_analyzer", "tsserver", "taplo" },
--})

--local lsp_config = require("lspconfig")
--local handlers = require("bizon.lsp.handlers")

--local opts = {
--  on_attach = handlers.on_attach,
--  capabilities = handlers.capabilities,
--}

--require("mason-lspconfig").setup_handlers({
--  -- The first entry (without a key) will be the default handler
--  -- and will be called for each installed server that doesn't have
--  -- a dedicated handler.
--  function(server_name) -- default handler (optional)
--    require("lspconfig")[server_name].setup(opts)
--  end,
--  -- Next, you can provide targeted overrides for specific servers.
--  ["tsserver"] = function()
--    local settings = require("bizon.lsp.settings.tsserver")
--    local config = vim.tbl_deep_extend("force", settings, opts)
--    lsp_config.tsserver.setup(config)
--  end,
--  ["sumneko_lua"] = function()
--    local settings = require("bizon.lsp.settings.sumneko_lua")
--    local config = vim.tbl_deep_extend("force", settings, opts)
--    lsp_config.sumneko_lua.setup(config)
--  end,
--  ["jsonls"] = function()
--    local settings = require("bizon.lsp.settings.jsonls")
--    local config = vim.tbl_deep_extend("force", settings, opts)
--    lsp_config.jsonls.setup(config)
--  end,
--  ["rust_analyzer"] = function()
--    lsp_config.rust_analyzer.setup({
--      cmd = { "rustup", "run", "nightly", "rust-analyzer" },
--      --[[
--    settings = {
--        rust = {
--            unstable_features = true,
--            build_on_save = false,
--            all_features = true,
--        },
--    }
--    --]]
--    })
--  end,
--})

--handlers.setup()

-- import mason plugin safely
local mason_status, mason = pcall(require, "mason")
if not mason_status then
  print("error masson ")
  return
end

-- import mason-lspconfig plugin safely
local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
  print("error mason_lspconfig_status")
  return
end

-- import mason-null-ls plugin safely
local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
  print("error mason_null_ls_status")
  return
end

-- enable mason
mason.setup()

mason_lspconfig.setup({
  -- list of servers for mason to install
  ensure_installed = {
    "rust_analyzer",
    "tsserver",
    "html",
    "cssls",
    "tailwindcss",
    "lua_ls",
  },
  -- auto-install configured servers (with lspconfig)
  automatic_installation = true, -- not the same as ensure_installed
})

mason_null_ls.setup({
  -- list of formatters & linters for mason to install
  ensure_installed = {
    "prettier", -- ts/js formatter
    "stylua", -- lua formatter
    "eslint_d", -- ts/js linter
  },
  -- auto-install configured formatters & linters (with null-ls)
  automatic_installation = true,
})
