local status_ok, plugin = pcall(require, "trouble")
if not status_ok then
  print("trouble failed")
  return
end

plugin.setup({})
