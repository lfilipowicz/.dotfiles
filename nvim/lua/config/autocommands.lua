-- HIGHLIGHTS YANKED WORDS
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  desc = "Highlight when yanking(copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function()
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = "*.templ",
      callback = function()
        local current_file = vim.fn.expand("%:p")
        vim.fn.system("templ generate -f " .. current_file)
      end,
    })
  end,
})
