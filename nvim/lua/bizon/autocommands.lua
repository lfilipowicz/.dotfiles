-- HIGHLIGHTS YANKED WORDS
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

-- FIX AUTOCOMANDS
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd("set formatoptions-=cro")
  end,
})

-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--   pattern = { "*.rs" },
--   callback = function()
--     vim.lsp.codelens.refresh()
--   end,
-- })

-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--   pattern = { "*" },
--   callback = function()
--     vim.cmd("FormatWrite<CR>")
--   end,
-- })

-- vim.cmd([[augroup FormatAutogroup
-- autocmd!
-- autocmd BufWritePost * FormatWrite
-- augroup END]])

-- -- Dotfile hooks
-- vim.cmd[[autocmd BufWritePost *tmux.conf !tmux source <afile>]]
-- vim.cmd[[autocmd BufWritePost *yabairc !brew services restart yabai]]
-- vim.cmd[[autocmd BufWritePost *skhdrc !brew services restart skhd]]
