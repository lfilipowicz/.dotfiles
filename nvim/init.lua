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

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    -- { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import any extras modules here
    -- { import = "lazyvim.plugins.extras.lang.typescript" },
    -- { import = "lazyvim.plugins.extras.lang.json" },
    -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
    -- import/override with your plugins
    { import = "plugins" },
  },
})

require("bizon.keymap")
require("bizon.autocommands")
require("bizon.treesitter")
require("bizon.lsp.cmp")
require("bizon.lsp.lspconfig")
require("bizon.lsp.mason")
require("bizon.remap")
require("bizon.colors")
require("bizon.lualine")
require("bizon.gitsigns")
