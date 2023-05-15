local status_ok, plugin = pcall(require, "alpha")
if not status_ok then
    print("alpha plugin failed")
    return
end

plugin.setup(require("alpha.themes.dashboard").config)
