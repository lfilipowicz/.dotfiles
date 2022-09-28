local rt = require("rust-tools")

local handlers = require("bizon.lsp.handlers")
rt.setup({
  server = {
    on_attach = handlers.on_attach
  },
})
