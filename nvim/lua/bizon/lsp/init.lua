require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "sumneko_lua", "rust_analyzer", "tsserver" }
})

require("mason-lspconfig").setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {
      on_attach = require("bizon.lsp.handlers").on_attach,
      capabalities = require("bizon.lsp.handlers").capabilities
    }
  end,
  -- Next, you can provide targeted overrides for specific servers.
  ["tsserver"] = function()
    local flags = require("bizon.lsp.settings.tsserver")
    require('lspconfig').tsserver.setup {
      falgs = flags,
      on_attach = require("bizon.lsp.handlers").on_attach,
      capabalities = require("bizon.lsp.handlers").capabilities
    }
  end,
  ["sumneko_lua"] = function()
    local settings = require('bizon.lsp.settings.sumneko_lua')
    require("lspconfig").sumneko_lua.setup {
      settings = settings,
      on_attach = require("bizon.lsp.handlers").on_attach,
      capabalities = require("bizon.lsp.handlers").capabilities
    }
  end,
  ["jsonls"] = function()
    local config = require('bizon.lsp.settings.jsonls')
    require("lspconfig").jsonls.setup({
      settings = config.settings,
      setup = config.setup,
      on_attach = require("bizon.lsp.handlers").on_attach,
      capabalities = require("bizon.lsp.handlers").capabilities
    })
  end,
})

require('mason-lspconfig')
require("bizon.lsp.handlers").setup()
