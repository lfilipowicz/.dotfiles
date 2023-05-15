local on_attach = require("bizon.lsp.lspconfig").on_attach
local capabilities = require("bizon.lsp.lspconfig").capabilities

return {
  {
    "saecki/crates.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = { "rust", "toml" },
    config = function(_, opts)
      local create = require("crates")
      create.setup(opts)
      create.show()
    end,
    opts = function()
      return { null_ls = { enabled = true, name = "crates.nvim" } }
    end,
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    dependencies = "neovim/nvim-lspconfig",
    ft = "rust",
    config = function(_, opts)
      require("rust-tools").setup(opts)
    end,
    opts = function()
      return {
        tools = {
          runnables = { use_telescope = true },
          hover_actions = { auto_focus = true },
        },
        server = {
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = { command = "clippy" },
              imports = {
                granularity = {
                  group = "module",
                },
                prefix = "self",
              },
              cargo = {
                buildScripts = {
                  enable = true,
                },
              },
              procMacro = {
                enable = true,
              },
            },
          },
        },
      }
    end,
  },
}
