local status_ok, plugin = pcall(require, "lspsaga")

if not status_ok then
  print("lspsaga fails")
  return
end

plugin.init_lsp_saga({
  symbol_in_winbar = {
    in_custom = false,
    enable = true,
    separator = " ",
    show_file = true,
    click_support = false,
  },
})
