return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
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
}
