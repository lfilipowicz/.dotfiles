-- NETRW
vim.keymap.set("n", "<leader>pv", ":Explore<cr>", { desc = "Open Netrw Explorer" })
-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
-- MOVE TEXT UP AND DOWN
--u
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line up" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line Down" })
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { desc = "[U]ndotree" })
vim.keymap.set("x", "<leader>p", '"_dP', { noremap = true, silent = true, desc = "Past" })
vim.keymap.set("n", "x", '"_x', { noremap = true, silent = true, desc = "Delete Character" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Jump Up" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Jump Down" })
-- serarch results on the middle
vim.keymap.set("n", "N", "Nzzzv", { noremap = true, silent = true, desc = "Search Previous Result" })
vim.keymap.set("n", "n", "nzzzv", { noremap = true, silent = true, desc = "Search Next Result" })
-- nnoremap("Q", "<nop>", opts)
if vim.lsp.inlay_hint then
  vim.keymap.set("n", "<leader>uh", function()
    vim.lsp.inlay_hint(0, nil)
  end, { desc = "Toggle Inline Hints" })
end

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- quickfix
-- vim.keymap.set("n", "<C-a>", ":cn<CR>", { noremap = true, silent = true, desc = "Quickfix Next Result" })
-- vim.keymap.set("n", "<C-s>", ":cp<CR>", { noremap = true, silent = true, desc = "Quickfix Previous Result" })
