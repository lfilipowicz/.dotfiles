local nnoremap = require("bizon.keymap").nnoremap
local inoremap = require("bizon.keymap").inoremap
local vnoremap = require("bizon.keymap").vnoremap

local opts = { noremap = true, silent = true }

-- NETRW
nnoremap("<leader>pv", "<cmd>Ex<CR>")

--- telescope
nnoremap("<leader>ff", "<cmd>lua require('telescope.builtin').find_files({hidden = true})<cr>")
nnoremap("<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
nnoremap("<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>")
nnoremap("<leader>fgs", "<cmd>lua require('telescope.builtin').git_status()<cr>")
nnoremap("<leader>fgb", "<cmd>lua require('telescope.builtin').git_branches()<cr>")
nnoremap("<leader>fp", "<cmd>Telescope projects<cr>")

-- MOVE TEXT UP AND DOWN
nnoremap("<S-UP>", ":m .-2<CR>==")
nnoremap("<S-DOWN>", ":m .+1<CR>==")

-- RESIZE WINDOW

nnoremap("<A-UP>", ":resize -2<CR>", opts)
nnoremap("<A-DOWN>", ":resize +2<CR>", opts)
nnoremap("<A-LEFT>", ":vertical resize -2<CR>", opts)
nnoremap("<A-RIGHT>", ":vertical resize +2<CR>", opts)

-- ESCAPE FASTER
inoremap("jj", "<ESC>", opts)

-- NVTree
nnoremap("<leader>e", "<cmd>NvimTreeToggle<cr>", opts)

-- BUFFER SWITCHING
nnoremap("<S-l>", "<cmd>bnext<cr>", opts)
nnoremap("<S-h>", "<cmd>bprevious<cr>", opts)

-- LSP

nnoremap(
  "<leader>lf",
  "<cmd>lua vim.lsp.buf.format({async=true})<cr>",
  -- "<cmd>lua vim.lsp.buf.format({async=true, filter = function(client) return client.name ~= 'tsserver' end})<cr>",
  opts
)
nnoremap("<leader>li", "<cmd>LspInfo<cr>", opts)
nnoremap("<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
nnoremap("<leader>la", "<cmd>Lspsaga code_action<CR>", opts)
nnoremap("<leader>lj", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
nnoremap("<leader>lk", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
nnoremap("<leader>lr", "<cmd>Lspsaga rename<CR>", opts)

-- LSP SAGA
vnoremap("<leader>ca", "<cmd>Lspsaga range_code_action<CR>", opts)
nnoremap("<leader>gr", "<cmd>Lspsaga lsp_finder<CR>", opts)

-- Trouble
nnoremap("<leader>xx", "<cmd>Trouble<cr>", opts)
nnoremap("<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", opts)
nnoremap("<leader>xd", "<cmd>Trouble document_diagnostics<cr>", opts)
nnoremap("<leader>xl", "<cmd>Trouble loclist<cr>", opts)
nnoremap("<leader>xq", "<cmd>Trouble quickfix<cr>", opts)
nnoremap("<leader>xr", "<cmd>Trouble lsp_references<cr>", opts)

local nvim_tmux_nav = require("nvim-tmux-navigation")

vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
