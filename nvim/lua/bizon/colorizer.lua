local status_ok, plugin = pcall(require, "colorizer")
if not status_ok then
	print("colorizer failed")
	return
end

plugin.setup({ "*" })
