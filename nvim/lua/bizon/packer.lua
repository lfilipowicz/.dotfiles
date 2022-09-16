-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])
return require("packer").startup(function(use)
  use("wbthomason/packer.nvim")

  use("nvim-lua/plenary.nvim")
  use("kyazdani42/nvim-web-devicons")
  -- LSP
  use { "williamboman/mason.nvim" }
  use({ "williamboman/mason-lspconfig.nvim" })
  use("neovim/nvim-lspconfig")
  use("glepnir/lspsaga.nvim")

  -- CMP
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-cmdline")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-nvim-lua")
  use("saadparwaiz1/cmp_luasnip")
  use("onsails/lspkind-nvim")

  use({
    "nvim-lualine/lualine.nvim",
    requires = {
      "kyazdani42/nvim-web-devicons",
      opt = true,
    },
  })
  use({ "catppuccin/nvim", as = "catppuccin" })

  use("L3MON4D3/LuaSnip") --snippet engine
  use("rafamadriz/friendly-snippets") -- a bunch of snip pets to use

  use("tpope/vim-commentary")
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })
  use("nvim-treesitter/nvim-treesitter-context")

  --     -- TELESCOPE
  use("nvim-lua/popup.nvim")
  use("nvim-telescope/telescope.nvim")
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use("JoosepAlviste/nvim-ts-context-commentstring")
  -- GIT
  use("lewis6991/gitsigns.nvim")
  use("RRethy/vim-illuminate")


  use("goolord/alpha-nvim")
  use("norcalli/nvim-colorizer.lua")

  use({
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
  })
  use({ "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons" })
  use({
    "alexghergh/nvim-tmux-navigation",
    config = function()
      local nvim_tmux_nav = require("nvim-tmux-navigation")

      nvim_tmux_nav.setup({
        disable_when_zoomed = true, -- defaults to false
      })
    end,
  })
  use("APZelos/blamer.nvim")

end)
