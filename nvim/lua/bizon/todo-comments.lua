local status_ok, plugin = pcall(require, "todo-comments")
if not status_ok then
  print("todo-comments failed")
  return
end

plugin.setup({})
