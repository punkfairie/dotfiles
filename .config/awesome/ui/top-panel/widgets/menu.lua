local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful").get()
local helpers = require("helpers")

-- Menu
local menu = wibox.widget({
	{
		font = beautiful.font_name .. "16",
		markup = "󰜬",
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
