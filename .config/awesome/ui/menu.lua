local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local beautiful = require("beautiful")
local wibox = require("wibox")

local helpers = require("helpers")
local apps = require("config").apps

local menu = {}

local rofi = {}
rofi.timer = gears.timer({
	autostart = false,
	timeout = 0.1,
	single_shot = true,
	callback = function()
		awful.spawn("rofi -show drun -theme ~/.config/rofi/launcher.rasi")
	end,
})

menu.awesome = {
	{
		"Hotkeys",
		function()
			hotkeys_popup.show_help(nil, awful.screen.focused())
		end,
	},
	{ "Manual", apps.terminal .. " -e man awesome" },
	{ "Edit Config", apps.start_editor .. " " .. awesome.conffile },
	{ "Restart", awesome.restart },
	{
		"Quit",
		function()
			awesome.quit()
		end,
	},
}

menu.mainmenu = awful.menu({
	items = {
		{
			"Applications",
			function()
				menu.mainmenu:hide()
				rofi.timer:start()
			end,
		},
		{ "Terminal", apps.terminal },
		{ "Web Browser", apps.browser },
		-- { "File Manager", apps.file_manager },
		{ "Text Editor", apps.editor },
		-- { "Music Player", apps.music_player },
		{
			"Info Panel",
			function()
				awesome.emit_signal("sidebar::toggle")
			end,
		},
		{
			"Notifications",
			function()
				awesome.emit_signal("action::toggle")
			end,
		},
		{
			"Exit",
			function()
				awesome.emit_signal("module::exit_screen:show")
			end,
		},
		{ "AwesomeWM", menu.awesome },
	},
})

-- Apply rounded corners to menus when picom isn't available.
-- Also applies anti-aliasing.
menu.mainmenu.wibox.shape = helpers.ui.rrect(10)
menu.mainmenu.wibox.bg = beautiful.bg_normal .. "00"
menu.mainmenu.wibox:set_widget(wibox.widget({
	menu.mainmenu.wibox.widget,
	bg = beautiful.bg_normal,
	shape = helpers.ui.rrect(0),
	widget = wibox.container.background,
}))

-- Apply rounded corners to submenus.
-- Also applies anti-aliasing.
awful.menu.original_new = awful.menu.new

---@diagnostic disable-next-line: duplicate-set-field
function awful.menu.new(...)
	local ret = awful.menu.original_new(...)

	ret.wibox.shape = helpers.ui.rrect(10)
	ret.wibox.bg = beautiful.bg_normal .. "00"
	ret.wibox:set_widget(wibox.widget({
		ret.wibox.widget,
		widget = wibox.container.background,
		bg = beautiful.xcolorbase,
		shape = helpers.ui.rrect(10),
	}))

	return ret
end

return menu
