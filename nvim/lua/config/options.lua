local options = {
  backup = false,
  clipboard = "unnamedplus",
  cmdheight = 1,
  completeopt = { "menu", "menuone", "noselect" },
  conceallevel = 0,
  -- colorcolumn = "80",
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
  showcmd = false,
  showmode = false,
  showtabline = 0,
  signcolumn = "yes",
  smartcase = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  -- Decrease update time
  updatetime = 250,
  timeoutlen = 300,
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
  ch = 0, -- not working without hit-enter prompt in netrw :(
  backspace = { "indent", "eol", "start" },
  termguicolors = true,
  cursorline = true,
  breakindent = true,
  list = true,
  listchars = { tab = "» ", trail = "·", nbsp = "␣" },
  inccommand = "split",
  scrolloff = 10,
}

local globals = {
  mapleader = " ",
  maplocalleader = " ",
  markdown_fenced_languages = { "vim", "lua", "javascript", "typescript", "html", "css", "scss", "rust" },
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

vim.g.rustfmt_autosave = 1
vim.g.rustfmt_emit_files = 1
vim.g.rustfmt_fail_silently = 0

vim.g.netrw_keepdir = 0
-- vim.g.netrw_localcopydircmd = "cp -r"
vim.g.netrw_silent = 1

vim.filetype.add({
  extension = {
    templ = "templ",
  },
})
vim.lsp.set_log_level("off")
vim.opt.spell = true
vim.opt.spelllang = "en_us,pl"
