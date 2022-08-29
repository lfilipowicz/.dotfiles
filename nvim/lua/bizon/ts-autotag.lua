local status_ok, plugin = pcall(require, "nvim-ts-autotag")
if not status_ok then
  print("nvim-ts-autotag failed")
end
plugin.setup()
