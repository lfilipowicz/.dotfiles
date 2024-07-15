local wezterm = require("wezterm")
local mux = wezterm.mux
local action = wezterm.action
local KeyMultiple = action.Multiple
local tmux_leader = { key = "b", mods = "CTRL" }

local config = wezterm.config_builder()
config.color_scheme = "Catppuccin Macchiato"
-- config.font = wezterm.font("Dank Mono")
config.font = wezterm.font("JetBrains Mono")
config.font_size = 14
config.hide_tab_bar_if_only_one_tab = true

config.audible_bell = "Disabled"

config.window_padding = {
	left = 2,
	right = 5,
	top = 2,
	bottom = 0,
}

config.window_decorations = "RESIZE"

config.keys = {

	-- INFO: find project
	{
		key = "f",
		mods = "CMD",
		action = KeyMultiple({ action.SendKey(tmux_leader), action.SendKey({ key = "f" }) }),
	},
	-- INFO: # create tmux new pane
	{
		key = "t",
		mods = "CMD",
		action = KeyMultiple({ action.SendKey(tmux_leader), action.SendKey({ key = "c" }) }),
	},
	-- INFO:  Select a tmux session for the attached client interactively
	{
		key = "k",
		mods = "CMD",
		action = KeyMultiple({ action.SendKey(tmux_leader), action.SendKey({ key = "s" }) }),
	},
	-- INFO: Open lazygit
	{
		key = "g",
		mods = "CMD",
		action = KeyMultiple({ action.SendKey(tmux_leader), action.SendKey({ key = "g" }) }),
	},
	-- INFO:  Split the current pane into two, top and bottom.
	{
		key = "n",
		mods = "CMD",
		action = KeyMultiple({ action.SendKey(tmux_leader), action.SendKey({ key = '"' }) }),
	},
	-- INFO:  Split the current pane into two, left and right
	{
		key = "n",
		mods = "CMD|SHIFT",
		action = wezterm.action({ SendString = "\x02\x25" }),
	},
	-- INFO: Toggle the zoom state of the current tmux pane
	{
		key = "z",
		mods = "CMD",
		action = wezterm.action({ SendString = "\x02\x7a" }),
	},
	-- INFO: save file - ESC :w Enter
	{
		key = "s",
		mods = "CMD",
		action = wezterm.action({ SendString = "\x1b\x3a\x77\x0a" }),
	},
	-- INFO: save all files - ESC :w Enter
	{
		key = "s",
		mods = "CMD|SHIFT",
		action = wezterm.action({ SendString = "\x1b\x3a\x77\x61\x0a" }),
	},
	-- INFO:  kill pane <C-b> + x
	{
		key = "w",
		mods = "CMD",
		action = wezterm.action({ SendString = "\x02\x78" }),
	},
	-- INFO:  rename session <C-b> + r
	{
		key = "r",
		mods = "CMD",
		action = wezterm.action({ SendString = "\x02\x240" }),
	},
	-- INFO:  rename pane <C-b> + r
	{
		key = ",",
		mods = "CMD",
		action = wezterm.action({ SendString = "\x02\x2c" }),
	},
}

-- INFO: pane switch
local panes =
	{ "\x02\x31", "\x02\x32", "\x02\x33", "\x02\x34", "\x02\x35", "\x02\x36", "\x02\x37", "\x02\x38", "\x02\x39" }

for index, val in ipairs(panes) do
	table.insert(config.keys, { key = tostring(index), mods = "CMD", action = wezterm.action({ SendString = val }) })
end

wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

return config
