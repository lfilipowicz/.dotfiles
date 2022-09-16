require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "sumneko_lua", "rust_analyzer", "tsserver" }
})

local lsp_config = require("lspconfig");
local handlers = require("bizon.lsp.handlers")

local opts = {
  on_attach = handlers.on_attach,
  capabilities = handlers.capabilities
}


require("mason-lspconfig").setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup(opts)
  end,
  -- Next, you can provide targeted overrides for specific servers.
  ["tsserver"] = function()
    local settings = require("bizon.lsp.settings.tsserver")
    local config = vim.tbl_deep_extend("force", settings, opts)
    lsp_config.tsserver.setup(config)
  end,
  ["sumneko_lua"] = function()
    local settings = require('bizon.lsp.settings.sumneko_lua')
    local config = vim.tbl_deep_extend("force", settings, opts)
    lsp_config.sumneko_lua.setup(config)
  end,
  ["jsonls"] = function()
    local settings = require('bizon.lsp.settings.jsonls')
    local config = vim.tbl_deep_extend("force", settings, opts)
    lsp_config.jsonls.setup(config)
  end,
})

handlers.setup()
