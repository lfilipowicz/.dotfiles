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
    -- TODO: diagnostics.cspell.with({ "--config $HOME/.cspell/cspell.json" }),
    diagnostics.codespell,
    formatting.codespell,
    diagnostics.flake8,
    diagnostics.shellcheck,
    diagnostics.jsonlint,
    diagnostics.luacheck,
    diagnostics.zsh,
  },
})
