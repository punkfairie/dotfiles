local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers.ui")
local config = require("config")

local dpi = beautiful.xresources.apply_dpi

-- Menu
local menu = wibox.widget({
	{
		font = helpers.set_font("16"),
		markup = config.icons.menu,
		widget = wibox.widget.textbox(),
	},
	bottom = dpi(2),
	widget = wibox.container.margin,
})

helpers.add_hover_cursor(menu, "hand2")

menu:add_button(awful.button({}, 1, function()
	awesome.emit_signal("sidebar::toggle")
end))

return menu
