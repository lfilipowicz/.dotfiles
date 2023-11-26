return {
  "nvim-lua/plenary.nvim",
  { "nvim-tree/nvim-web-devicons", lazy = true },
  "sindrets/diffview.nvim",
  "neovim/nvim-lspconfig",
  {
    "glepnir/lspsaga.nvim",
    keys = {
      {
        "K",
        "<cmd>Lspsaga hover_doc<cr>",
        desc = "LSPSaga hover doc",
      },
    },

    config = function()
      require("lspsaga").setup({

        -- keybinds for navigation in lspsaga window
        move_in_saga = { prev = "<C-k>", next = "<C-j>" },
        -- use enter to open file with finder
        -- use enter to open file with definition preview
        ui = {
          border = "single",
        },
        lightbulb = { enable = false },
      })
    end,
    event = "LspAttach",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-buffer",
  "saadparwaiz1/cmp_luasnip",
  "onsails/lspkind-nvim",
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      opt = true,
    },
  },
  { "catppuccin/nvim", as = "catppuccin" },
  "L3MON4D3/LuaSnip",
  "rafamadriz/friendly-snippets",
  -- GIT
  "lewis6991/gitsigns.nvim",
  {
    "alexghergh/nvim-tmux-navigation",
    config = function()
      local nvim_tmux_nav = require("nvim-tmux-navigation")

      nvim_tmux_nav.setup({
        disable_when_zoomed = true, -- defaults to false
      })
    end,
  },
  -- formatting & linting
  "jose-elias-alvarez/typescript.nvim", -- additional functionality for typescript server (e.g. rename file & update imports)
  {
    "ThePrimeagen/harpoon",
    config = function()
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")
      vim.keymap.set("n", "<leader>a", mark.add_file)
      vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
      vim.keymap.set("n", "<C-n>", function()
        ui.nav_next()
      end)
      vim.keymap.set("n", "<C-n>", function()
        ui.nav_prev()
      end)
    end,
  },
  "mbbill/undotree",
  "tpope/vim-fugitive",
  "tpope/vim-commentary",
  {
    "ThePrimeagen/git-worktree.nvim",
    config = function()
      require("telescope").load_extension("git_worktree")
    end,
    requires = { "telescope" },
    keys = {
      {
        "<leader>fw",
        "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>",
        desc = "Git Worktree List",
      },
      {
        "<leader>fW",
        "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>",
        desc = "Git Worktree Create",
      },
    },
  },
}
