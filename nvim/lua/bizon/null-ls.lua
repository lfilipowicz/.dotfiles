local status_ok, plugin = pcall(require, "null-ls")
if not status_ok then
  print("null-ls failed")
  return
end

local formatting = plugin.builtins.formatting
local diagnostics = plugin.builtins.diagnostics

plugin.setup({
  debug = false,
  sources = {
    formatting.prettier,
    formatting.stylua,
    formatting.shfmt,
    diagnostics.eslint,
    diagnostics.codespell,
    diagnostics.flake8,
    diagnostics.shellcheck,
  },
})
