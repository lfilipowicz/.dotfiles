local keymap = require("vim.keymap")
return {
  "nvim-lua/plenary.nvim",
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "sindrets/diffview.nvim", lazy = true },
  { -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for neovim
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { "j-hui/fidget.nvim", opts = {} },
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
  },
  -- {
  --   "ray-x/go.nvim",
  --   dependencies = { -- optional packages
  --     "nvim-neotest/neotest",
  --     "nvim-neotest/nvim-nio",
  --     "ray-x/guihua.lua",
  --     "neovim/nvim-lspconfig",
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  --   opts = {
  --     tag_transform = "camelcase", -- can be transform option("snakecase", "camelcase", etc) check gomodifytags for details and more options
  --     lsp_inlay_hints = {
  --       enable = false,
  --       -- only_current_line = false,
  --       -- style = "end-of-line",
  --     },
  --   },
  --   event = { "CmdlineEnter" },
  --   ft = { "go", "gomod" },
  --   build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  -- },
  { "RRethy/vim-illuminate", opt = true },
  -- GIT
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
    },
  },
  "mbbill/undotree",
  "tpope/vim-commentary",
  {
    "stevearc/oil.nvim",
    opts = {
      default_file_explorer = true,
      delete_to_trash = true,
      columns = { "icon" },
      keymaps = { ["C-h"] = false },
      view_options = { show_hidden = true, natural_order = true },
      win_options = { wrap = true },
    },
    keys = {
      { "<space>-", "<CMD>Oil<CR>", desc = "Open parent directory" },
      { "-", "<CMD>Oil --float<CR>", desc = "Open parent directory" },
    },

    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "MeanderingProgrammer/markdown.nvim",
    ft = "md",
    opts = {},
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      completions = { blink = { enabled = true } },
    },
  },
}
