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
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "hrsh7th/cmp-cmdline" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },
      { "hrsh7th/cmp-buffer" },
      { "saadparwaiz1/cmp_luasnip" },
      { "onsails/lspkind-nvim" },
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")
      require("luasnip.loaders.from_vscode").lazy_load()
      cmp.setup({

        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        completion = {
          completeopt = "menu,menuone,preview,noselect",
        },
        formatting = {
          fields = { "abbr", "kind", "menu" },
          format = lspkind.cmp_format({
            -- mode = "symbol_text",
            maxwidth = 50,
            elipsis_char = "...",
            -- before = function(entry, vim_item)
            --   vim_item.menu = source_maps[entry.source.name]
            --   return vim_item
            -- end,
            before = require("tailwindcss-colorizer-cmp").formatter,
          }),
        },
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- For luasnip users.
          { name = "buffer" },
          { name = "path" },
          { name = "crates" },
        }),
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      opt = true,
    },
  },
  {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require("catppuccin").setup({
        integrations = {
          illuminate = {
            enabled = true,
            lsp = false,
          },
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = false,
          mini = {
            enabled = true,
            indentscope_color = "",
          },
          -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
      })
    end,
  },
  { "RRethy/vim-illuminate", opt = true },
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
