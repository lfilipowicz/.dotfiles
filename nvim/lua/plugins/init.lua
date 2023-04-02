return {
  "folke/which-key.nvim",
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  {
    "glepnir/lspsaga.nvim",
    event = "BufRead",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
  "simrat39/rust-tools.nvim",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-buffer",
  "saadparwaiz1/cmp_luasnip",
  "hrsh7th/cmp-nvim-lsp-signature-help",
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
  "tpope/vim-commentary",
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  "nvim-treesitter/nvim-treesitter-context",
  "nvim-lua/popup.nvim",
  "JoosepAlviste/nvim-ts-context-commentstring",
  -- GIT
  "lewis6991/gitsigns.nvim",

  "goolord/alpha-nvim",

  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
  },
  { "folke/trouble.nvim", dependencies = "nvim-tree/nvim-web-devicons" },
  {
    "alexghergh/nvim-tmux-navigation",
    config = function()
      local nvim_tmux_nav = require("nvim-tmux-navigation")

      nvim_tmux_nav.setup({
        disable_when_zoomed = true, -- defaults to false
      })
    end,
  },
  "windwp/nvim-autopairs", -- autoclose parens, brackets, quotes, etc...0
  -- formatting & linting
  "jayp0521/mason-null-ls.nvim", -- bridges gap b/w mason & null-ls
  "jose-elias-alvarez/null-ls.nvim", -- configure formatters & linters
  "jose-elias-alvarez/typescript.nvim", -- additional functionality for typescript server (e.g. rename file & update imports)

  "ThePrimeagen/harpoon",
  "mbbill/undotree",

  {
    "saecki/crates.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup({ null_ls = { enabled = true, name = "crates.nvim" } })
    end,
  },
  "tpope/vim-fugitive",
}
