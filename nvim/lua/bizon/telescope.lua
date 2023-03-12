-- Telescope 🔭 - setup and customized pickers
local utils = require("telescope.utils")

-- my telescopic customizations
local M = {}

-- requires repo extension
function M.repo_list()
  local opts = {}
  opts.prompt_title = " Repos"
  require("telescope").extensions.repo.list(opts)
end

-- requires GitHub extension
function M.gh_issues()
  local opts = {}
  opts.prompt_title = " Issues"
  require("telescope").extensions.gh.issues(opts)
end

function M.gh_prs()
  local opts = {}
  opts.prompt_title = " Pull Requests"
  require("telescope").extensions.gh.pull_request(opts)
end
-- end github functions

-- grep_string pre-filtered from grep_prompt
local function grep_filtered(opts)
  opts = opts or {}
  require("telescope.builtin").grep_string({
    path_display = { "smart" },
    search = opts.filter_word or "",
  })
end

-- open vim.ui.input dressing prompt for initial filter
function M.grep_prompt()
  vim.ui.input({ prompt = "Rg " }, function(input)
    grep_filtered({ filter_word = input })
  end)
end

-- search Neovim related todos
function M.search_todos()
  require("telescope.builtin").grep_string({
    prompt_title = " Search TODOs",
    prompt_prefix = " ",
    results_title = "Neovim TODOs",
    path_display = { "smart" },
    search = "TODO",
  })
end

-- grep Neovim source using cword
function M.grep_nvim_src()
  require("telescope.builtin").grep_string({
    results_title = "Neovim Source Code",
    path_display = { "smart" },
    search_dirs = {
      "~/vim-dev/sources/neovim/runtime/lua/vim/",
      "~/vim-dev/sources/neovim/src/nvim/",
    },
  })
end

M.project_files = function()
  local _, ret, stderr = utils.get_os_command_output({
    "git",
    "rev-parse",
    "--is-inside-work-tree",
  })

  local gopts = {}
  local fopts = {}

  gopts.prompt_title = " Find"
  gopts.prompt_prefix = "  "
  gopts.results_title = " Repo Files"

  fopts.hidden = true
  fopts.file_ignore_patterns = {
    ".vim/",
    ".local/",
    ".cache/",
    "Downloads/",
    ".git/",
    "Dropbox/.*",
    "Library/.*",
    ".rustup/.*",
    "Movies/",
    ".cargo/registry/",
  }

  if ret == 0 then
    require("telescope.builtin").git_files(gopts)
  else
    fopts.results_title = "CWD: " .. vim.fn.getcwd()
    require("telescope.builtin").find_files(fopts)
  end
end

-- @TODOUA: break up notes and configs
function M.grep_notes()
  local opts = {}
  opts.hidden = true
  opts.search_dirs = {
    "~/notes/",
  }
  opts.prompt_prefix = "   "
  opts.prompt_title = " Grep Notes"
  opts.path_display = { "smart" }
  require("telescope.builtin").live_grep(opts)
end

function M.find_notes()
  require("telescope.builtin").find_files({
    prompt_title = " Find Notes",
    path_display = { "smart" },
    cwd = "~/notes/",
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65, width = 0.75 },
  })
end

function M.browse_notes()
  require("telescope").extensions.file_browser.file_browser({
    prompt_title = " Browse Notes",
    prompt_prefix = " ﮷ ",
    cwd = "~/notes/",
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65, width = 0.75 },
  })
end

function M.find_configs()
  require("telescope.builtin").find_files({
    prompt_title = " NVim & Term Config Find",
    results_title = "Config Files Results",
    path_display = { "smart" },
    search_dirs = {
      "~/.oh-my-zsh/custom",
      "~/.config/nvim",
      "~/.config/alacritty",
    },
    -- cwd = "~/.config/nvim/",
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65, width = 0.75 },
  })
end

function M.nvim_config()
  require("telescope").extensions.file_browser.file_browser({
    prompt_title = " NVim Config Browse",
    cwd = "~/.config/nvim/",
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65, width = 0.75 },
  })
end

function M.file_explorer()
  require("telescope").extensions.file_browser.file_browser({
    prompt_title = " File Browser",
    path_display = { "smart" },
    cwd = "~",
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65, width = 0.75 },
  })
end

return M
