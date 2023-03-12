local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("bizon.options")

require("lazy").setup("plugins")

require("bizon.keymap")
require("bizon.autocommands")
require("bizon.treesitter")
require("bizon.lsp.cmp")
require("bizon.lsp.lspconfig")
require("bizon.lsp.null-ls")
require("bizon.lsp.lspsaga")
require("bizon.lsp.mason")
require("bizon.remap")
