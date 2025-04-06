return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  config = function()
    -- load the colorscheme here
    vim.cmd([[colorscheme catppuccin-macchiato]])
  end,
  opts = {
    integrations = {

      blink_cmp = true,
      harpoon = true,
      cmp = true,
      fzf = true,
      gitsigns = true,
      illuminate = true,
      lsp_trouble = true,
      mason = true,
      treesitter = true,
      treesitter_context = true,
      mini = true,
      neotest = true,
      notify = true,
      telescope = true,
      which_key = true,
      semantic_tokens = true,
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
      },
    },
  },
}
