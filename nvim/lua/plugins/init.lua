return {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    {
        "nvim-neorg/neorg",
        run = ":Neorg sync-parsers", -- This is the important bit!
        config = function()
            require("neorg").setup({
                load = {
                    ["core.defaults"] = {},
                    ["core.concealer"] = {
                        config = { icon_preset = "diamond" },
                    },
                    ["core.dirman"] = {
                        config = {
                            workspaces = {
                                travel = "~/notes/travel",
                                work = "~/notes/work",
                                home = "~/notes/home",
                            },
                            default_workspace = "work",
                        },
                    },
                },
                -- configuration here
            })
        end,
    },
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
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "onsails/lspkind-nvim",
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            opt = true,
        },
    },
    { "catppuccin/nvim",                 as = "catppuccin" },
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-lua/popup.nvim",
    "JoosepAlviste/nvim-ts-context-commentstring",
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
    "windwp/nvim-autopairs",            -- autoclose parens, brackets, quotes, etc...0
    -- formatting & linting
    "jose-elias-alvarez/typescript.nvim", -- additional functionality for typescript server (e.g. rename file & update imports)
    "ThePrimeagen/harpoon",
    "mbbill/undotree",
    "tpope/vim-fugitive",
    "tpope/vim-commentary",
    { "akinsho/toggleterm.nvim", version = "*", config = true },
    {
        "lmburns/lf.nvim",
        config = function()
            -- This feature will not work if the plugin is lazy-loaded
            vim.g.lf_netrw = 1

            require("lf").setup({
                escape_quit = false,
                border = "rounded",
                -- highlights = {FloatBorder = {guifg = require("kimbox.palette").colors.magenta}}
            })

            vim.keymap.set("n", "<C-o>", ":Lf<CR>")
        end,
        requires = { "plenary.nvim", "toggleterm.nvim" },
    },
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
