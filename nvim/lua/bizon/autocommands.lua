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

vim.api.nvim_create_autocmd({ "BufWritePost" }, {

  pattern = { "*tmux.conf" },
  callback = function()
    vim.cmd("!tmux source <afile><CR>")
  end,
})
-- -- Dotfile hooks
-- vim.cmd[[autocmd BufWritePost *tmux.conf !tmux source <afile>]]
-- vim.cmd[[autocmd BufWritePost *yabairc !brew services restart yabai]]
-- vim.cmd[[autocmd BufWritePost *skhdrc !brew services restart skhd]]
