local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local awful = require("awful")

local helpers = require("helpers")

local menu = wibox.widget({
	{
		font = beautiful.font_name .. "16",
		markup = "<span foreground='" .. beautiful.color.pink .. "'>󰋒</span>",
		widget = wibox.widget.textbox(),
	},
	bottom = 2,
	widget = wibox.container.margin,
})

helpers.ui.add_hover_cursor(menu, "hand2")

menu:buttons(gears.table.join(awful.button({}, 1, function()
	awesome.emit_signal("sidebar::toggle")
end)))

return menu
