local options = {
  backup = false,
  clipboard = "unnamedplus",
  cmdheight = 1,
  completeopt = { "menu", "menuone", "noselect" },
  conceallevel = 0,
  colorcolumn = "80",
  errorbells = false,
  fileencoding = "utf-8",
  guicursor = "i:ver25",
  hlsearch = false,
  ignorecase = true,
  incsearch = true,
  laststatus = 3,
  mouse = "a",
  number = true,
  relativenumber = true,
  ruler = false,
  scrolloff = 8,
  showcmd = false,
  showmode = false,
  showtabline = 0,
  signcolumn = "yes",
  smartcase = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  -- timeoutlen = 500,
  undodir = os.getenv("HOME") .. "/.vim/undodir",
  undofile = true,
  -- winbar = "%{%v:lua.require'nvim-navic'.get_location()%} %=%m %f",
  -- winbar = "%=%m %f",
  wrap = false,
  writebackup = false,
  tabstop = 4,
  softtabstop = 4,
  expandtab = true,
  shiftwidth = 4,
  -- ch = 0, -- not working without hit-enter prompt in netrw :(
  backspace = { "indent", "eol", "start" },
  termguicolors = true,
  updatetime = 50,
  cursorline = true,
}

local globals = {
  mapleader = " ",
  maplocalleader = " ",
}

for key, value in pairs(options) do
  vim.opt[key] = value
end

for key, value in pairs(globals) do
  vim.g[key] = value
end

vim.opt.isfname:append("@-@")
vim.opt.shortmess:append("ctT")
vim.cmd([[set whichwrap=<,>,[,],h,l]])
vim.opt.iskeyword:append("-")

vim.g.blamer_enabled = 1
vim.g.blamer_delay = 500

vim.g.rustfmt_autosave = 1
vim.g.rustfmt_emit_files = 1
vim.g.rustfmt_fail_silently = 0

vim.g.netrw_keepdir = 0
-- vim.g.netrw_localcopydircmd = "cp -r"
vim.g.netrw_silent = 1
