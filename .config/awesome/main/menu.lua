local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local helpers = require("helpers")
local hotkeys_popup = require("awful.hotkeys_popup")

local theme = require("beautiful").get()
local apps = require("config").apps

local menu = {}

local rofi = {}
rofi.timer = gears.timer({
	autostart = false,
	timeout = 0.1,
	single_shot = true,
	callback = function()
		awful.spawn(apps.launcher)
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
		{ "File Manager", apps.file_manager },
		{ "Text Editor", apps.code_editor },
		{ "Music Player", apps.music_player },
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

-- apply rounded corners to menus when picom isn't available, thanks to u/signalsourcesexy
-- also applies antialiasing! - By me.
menu.mainmenu.wibox.shape = helpers.ui.rrect(10)
menu.mainmenu.wibox.bg = theme.bg_normal .. "00"
menu.mainmenu.wibox:set_widget(wibox.widget({
	menu.mainmenu.wibox.widget,
	bg = theme.bg_normal,
	shape = helpers.ui.rrect(0),
	widget = wibox.container.background,
}))

-- apply rounded corners to submenus, thanks to u/signalsourcesexy
-- also applies antialiasing! - By me.
awful.menu.original_new = awful.menu.new

---@diagnostic disable-next-line: duplicate-set-field
function awful.menu.new(...)
	local ret = awful.menu.original_new(...)

	ret.wibox.shape = helpers.ui.rrect(10)
	ret.wibox.bg = theme.bg_normal .. "00"
	ret.wibox:set_widget(wibox.widget({
		ret.wibox.widget,
		widget = wibox.container.background,
		bg = theme.color.base,
		shape = helpers.ui.rrect(0),
	}))

	return ret
end

return menu
