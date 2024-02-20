local awful = require("awful")
local volume = require("ui.popups.volume")
local filesystem = require("gears.filesystem")
local config_dir = filesystem.get_configuration_dir()
local utils_dir = config_dir .. "utilities/"

local keys = require("config").keys

local screenshot_area = utils_dir .. "screensht area"
local screenshot_full = utils_dir .. "screensht full"

awful.keyboard.append_global_keybindings({
	awful.key({ keys.mod }, "r", function()
		awful.spawn("rofi -show drun -theme ~/.config/rofi/launcher.rasi")
	end, { description = "show rofi", group = "launcher" }),
	awful.key({ keys.mod }, "Print", function()
		awful.spawn.easy_async_with_shell(screenshot_area, function() end)
	end, { description = "take a area screenshot", group = "Utils" }),
	awful.key({}, "Print", function()
		awful.spawn.easy_async_with_shell(screenshot_full, function() end)
	end, { description = "take a full screenshot", group = "Utils" }),
	awful.key({ keys.mod }, "q", function()
		awesome.emit_signal("module::exit_screen:show")
	end, { description = "show Exit Screen", group = "Utils" }),
	awful.key({ keys.mod }, "s", function()
		awesome.emit_signal("scratchpad::toggle")
	end, { description = "show Scratchpad", group = "Utils" }),
	awful.key({ keys.mod }, "b", function()
		awful.spawn.easy_async_with_shell("headsetcontrol -l 0", function() end)
	end, { description = "headsetcontrol", group = "Utils" }),
	awful.key({ keys.mod }, "t", function()
		awful.titlebar.toggle(client.focus)
	end, { description = "toggle titlebar for active client", group = "Utils" }), -- Toggle titlebar
})

-- Volume
awful.keyboard.append_global_keybindings({
	awful.key({}, "XF86AudioRaiseVolume", function()
		volume.increase()
		awesome.emit_signal("widget::update_vol")
		awesome.emit_signal("module::volume_osd:show", true)
	end),
	awful.key({}, "XF86AudioLowerVolume", function()
		volume.decrease()
		awesome.emit_signal("widget::update_vol")
		awesome.emit_signal("module::volume_osd:show", true)
	end),
	awful.key({}, "XF86AudioMute", function()
		volume.mute()
		awesome.emit_signal("widget::update_vol")
		awesome.emit_signal("module::volume_osd:show", true)
	end),
})
