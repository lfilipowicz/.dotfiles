-- my telescopic customizations
return {
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  "nvim-telescope/telescope-ui-select.nvim",
  "nvim-telescope/telescope-file-browser.nvim",
  "nvim-telescope/telescope-ui-select.nvim",
  "LinArcX/telescope-command-palette.nvim",
  "AckslD/nvim-neoclip.lua",
  "cljoly/telescope-repo.nvim",
  "jvgrootveld/telescope-zoxide",

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-fzf-native.nvim" },
    config = function()
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")
      -- https://github.com/nvim-telescope/telescope.nvim/issues/1048
      local telescope_custom_actions = {}

      function telescope_custom_actions._multiopen(prompt_bufnr, open_cmd)
        local picker = action_state.get_current_picker(prompt_bufnr)
        local num_selections = #picker:get_multi_selection()
        if not num_selections or num_selections <= 1 then
          actions.add_selection(prompt_bufnr)
        end
        actions.send_selected_to_qflist(prompt_bufnr)
        vim.cmd("cfdo " .. open_cmd)
      end

      function telescope_custom_actions.multi_selection_open(prompt_bufnr)
        telescope_custom_actions._multiopen(prompt_bufnr, "edit")
      end
      require("telescope").setup({
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
          command_palette = {
            -- {
            --   "File",
            --   { "Yank Current File Name", ":lua require('joel.funcs').yank_current_file_name()" },
            --   { "Write Current Buffer", ":w" },
            --   { "Write All Buffers", ":wa" },
            --   { "Quit", ":qa" },
            --   { "File Browser", ":lua require'telescope'.extensions.file_browser.file_browser()", 1 },
            --   { "Search for Word", ":lua require('telescope.builtin').live_grep()", 1 },
            --   { "Project Files", ":lua require'joel.telescope'.project_files()", 1 },
            -- },
            {
              "Git(Hub)",
              { " Issues", "lua require'joel.telescope'.gh_issues()", 1 },
              { " Pulls", "lua require'joel.telescope'.gh_prs()", 1 },
              { " Status", "lua require'telescope.builtin'.git_status()", 1 },
              { " Branches", "lua require'telescope.builtin'.git_branches()", 1 },
              { " Diff Split Vertical", ":Gvdiffsplit!", 1 },
              { " Log", "lua require'telescope.builtin'.git_commits()", 1 },
              {
                " File History",
                ":lua require'telescope.builtin'.git_bcommits({prompt_title = '  ', results_title='Git File Commits'})",
                1,
              },
            },
            -- {
            --   "Notes",
            --   { "Browse Notes", "lua require'bizon.telescope'.browse_notes()", 1 },
            --   { "Find Notes", "lua require'bizon.telescope'.find_notes()", 1 },
            --   { "Search/Grep Notes", "lua require'bizon.telescope'.grep_notes()", 1 },
            -- },
            -- {
            --   "Toggle",
            --   { "cursor line", ":set cursorline!" },
            --   { "cursor column", ":set cursorcolumn!" },
            --   { "spell checker", ":set spell!" },
            --   { "relative number", ":set relativenumber!" },
            --   { "search highlighting", ":set hlsearch!" },
            --   { "Colorizer", ":ColorToggle" },
            --   { "Fold Column", ":lua require'joel.settings'.toggle_fold_col()" },
            -- },
            {
              "Neovim",
              { "checkhealth", ":checkhealth" },
              { "commands", ":lua require('telescope.builtin').commands()" },
              { "command history", ":lua require('telescope.builtin').command_history()" },
              { "registers", ":lua require('telescope.builtin').registers()" },
              { "options", ":lua require('telescope.builtin').vim_options()" },
              { "keymaps", ":lua require('telescope.builtin').keymaps()" },
              { "buffers", ":Telescope buffers" },
              { "search history", ":lua require('telescope.builtin').search_history()" },
              { "Search TODOS", ":lua require(bizon.telescope).search_todos()" },
            },
          },
        },
        defaults = {
          prompt_prefix = "? ",
          selection_caret = "-> ",
          path_display = { "truncate" },
          preview_title = false,
          file_ignore_patterns = { ".git" },
          layout_strategy = "vertical",
          mappings = {
            -- using custom temp multi-select maps
            -- https://github.com/nvim-telescope/telescope.nvim/issues/1048
            n = {
              ["<Del>"] = actions.close,
              ["<C-A>"] = telescope_custom_actions.multi_selection_open,
            },
            i = {
              ["<esc>"] = actions.close,
              ["<C-A>"] = telescope_custom_actions.multi_selection_open,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
          },
        },

        picker = {
          results_title = false,
        },
      })
      -- https://github.com/nvim-telescope/telescope-file-browser.nvim
      require("telescope").load_extension("file_browser")
      -- https://github.com/nvim-telescope/telescope-ui-select.nvim
      require("telescope").load_extension("ui-select")
      -- https://github.com/nvim-telescope/telescope-fzf-native.nvim#telescope-fzf-nativenvim
      require("telescope").load_extension("fzf")
      -- https://github.com/LinArcX/telescope-command-palette.nvim
      require("telescope").load_extension("command_palette")
      -- https://github.com/jvgrootveld/telescope-zoxide
      -- <leader>z
      require("telescope").load_extension("zoxide")

      -- https://github.com/cljoly/telescope-repo.nvim
      -- <leader>rl
      require("telescope").load_extension("repo")

      -- https://github.com/AckslD/nvim-neoclip.lua
      -- <C-n>
      require("telescope").load_extension("neoclip")

      -- GitHub CLI → local version
      -- require("telescope").load_extension("gh")
    end,
  },
}
