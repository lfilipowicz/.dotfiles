local status_ok, project = pcall(require, "project_nvim")
if not status_ok then
  print("project_nvim failed")
  return
end

project.setup()
require("telescope").load_extension("projects")
