local nnoremap = require("bizon.keymap").nnoremap
local inoremap = require("bizon.keymap").inoremap
local vnoremap = require("bizon.keymap").vnoremap
local xnoremap = require("bizon.keymap").xnoremap

local opts = { noremap = true, silent = true }

-- NETRW
nnoremap("<leader>pa", ":Explore %:p:h<cr>", opts)
nnoremap("<leader>pv", ":Explore<cr>", opts)

--- telescope
nnoremap("<leader>fF", "<cmd>lua require('telescope.builtin').git_files({hidden = true})<cr>", opts)
nnoremap("<leader>ff", "<cmd>lua require('telescope.builtin').find_files({hidden = true})<cr>", opts)
nnoremap("<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
nnoremap("<leader>fG", function()
  require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
end, opts)
nnoremap("<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)
nnoremap("<leader>fa", "<cmd>lua require('telescope.builtin').git_status()<cr>", opts)
nnoremap("<leader>fgb", "<cmd>lua require('telescope.builtin').git_branches()<cr>", opts)

-- MOVE TEXT UP AND DOWN
vnoremap("J", ":m '>+1<CR>gv=gv", opts)
vnoremap("K", ":m '<-2<CR>gv=gv", opts)
-- RESIZE WINDOW

nnoremap("<A-UP>", ":resize -2<CR>", opts)
nnoremap("<A-DOWN>", ":resize +2<CR>", opts)
nnoremap("<A-LEFT>", ":vertical resize -2<CR>", opts)
nnoremap("<A-RIGHT>", ":vertical resize +2<CR>", opts)

-- ESCAPE FASTER
inoremap("jj", "<ESC>", opts)

-- BUFFER SWITCHING
nnoremap("<S-l>", "<cmd>bnext<cr>", opts)
nnoremap("<S-h>", "<cmd>bprevious<cr>", opts)

-- LSP

nnoremap(
  "<leader>lf",
  "<cmd>FormatWrite<cr>",
  -- "<cmd>lua vim.lsp.buf.format({async=true, filter = function(client) return client.name ~= 'tsserver' end})<cr>",
  opts
)
nnoremap("<leader>li", "<cmd>LspInfo<cr>", opts)
nnoremap("<leader>lI", "<cmd>LspInstallInfo<cr>", opts)

-- LSP SAGA

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

xnoremap("<leader>p", '"_dP')
nnoremap("x", '"_x')

nnoremap("<leader>u", "<cmd>UndotreeToggle<cr>", opts)

nnoremap("<C-u>", "<C-u>zz", opts)
nnoremap("<C-d>", "<C-d>zz", opts)
nnoremap("<leader>lR", "<cmd>LspRestart<cr>", opts)

-- serarch results on the middle
nnoremap("N", "Nzzzv", opts)
nnoremap("n", "nzzzv", opts)

nnoremap("Q", "<nop>", opts)

nnoremap("<leader>rt", "<cmd>:RustRunnables<cr>", opts)
