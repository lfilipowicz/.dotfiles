vim.g.syntax_on = true

-- tokyo setup
-- local colorscheme = "tokyonight"
-- vim.g.tokyonight_style = "night"
-- vim.g.tokyonight_style = "storm"

-- cappuccino
-- local colorscheme = "catppuccin"
-- vim.g.catppuccin_flavour = "frappe" -- latte, frappe, macchiato, mocha
-- vim.g.catppuccin_flavour = "frappe" -- latte, frappe, macchiato, mocha

-- local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
-- if not status_ok then
--   vim.notify("colorscheme " .. colorscheme .. " not found!")
--   return
-- end

-- vim.api.nvim_command("colorscheme catppuccin-frappe")
-- vim.api.nvim_command("colorscheme catppuccin-frappe")
vim.api.nvim_command("colorscheme catppuccin-macchiato")
