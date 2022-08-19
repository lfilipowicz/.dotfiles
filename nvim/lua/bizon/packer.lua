-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])
return require("packer").startup(function(use)
  use("wbthomason/packer.nvim")

  use("nvim-lua/plenary.nvim")
  use("kyazdani42/nvim-web-devicons")
  -- LSP
  use("neovim/nvim-lspconfig")
  use("williamboman/nvim-lsp-installer")
  use("jose-elias-alvarez/null-ls.nvim")
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
  use("folke/tokyonight.nvim")

  use("L3MON4D3/LuaSnip") --snippet engine
  use("rafamadriz/friendly-snippets") -- a bunch of snip pets to use

  use("tpope/vim-commentary")
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })

  use("romgrk/nvim-treesitter-context")
  --     -- TELESCOPE
  use("nvim-lua/popup.nvim")
  use("nvim-telescope/telescope.nvim")
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use("JoosepAlviste/nvim-ts-context-commentstring")
  -- GIT
  use("lewis6991/gitsigns.nvim")
  use("christoomey/vim-tmux-navigator")
  use("lewis6991/impatient.nvim")
  use("ahmedkhalf/project.nvim")
  use("RRethy/vim-illuminate")
  use({
    "kyazdani42/nvim-tree.lua",
    requires = {
      "kyazdani42/nvim-web-devicons", -- optional, for file icons
    },
    tag = "nightly", -- optional, updated every week. (see issue #1193)
  })
  use("goolord/alpha-nvim")
  use("norcalli/nvim-colorizer.lua")
  -- use("SmiteshP/nvim-navic")

  use("windwp/nvim-ts-autotag")
  use("windwp/nvim-autopairs")
  -- use("f-person/git-blame.nvim")
end)
