-- formatting & linting
-- import null-ls plugin safely
local setup, null_ls = pcall(require, "null-ls")
if not setup then
  print("null ls failed")
  return
end

-- for conciseness
local formatting = null_ls.builtins.formatting -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters
local code_action = null_ls.builtins.code_actions

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- configure null_ls
null_ls.setup({
  -- debug = true,
  -- setup formatters & linters
  sources = {
    require("typescript.extensions.null-ls.code-actions"),
    formatting.prettierd, -- js/ts formatter
    formatting.stylua, -- lua formatter
    diagnostics.eslint_d,
    diagnostics.tsc,
    -- formatting.sqlfmt,
    formatting.shfmt,
    code_action.shellcheck,
    code_action.eslint,
  },
  -- configure format on save
  on_attach = function(current_client, bufnr)
    if current_client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            filter = function(client)
              --  only use null-ls for formatting instead of lsp server
              return client.name == "null-ls"
            end,
            bufnr = bufnr,
          })
        end,
      })
    end
  end,
})
