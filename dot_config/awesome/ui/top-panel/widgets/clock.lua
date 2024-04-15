local gears = require("gears")
local wibox = require("wibox")
local helpers = require("helpers")
local config = require("config")
local beautiful = require("beautiful")

local theme = beautiful.get()
local dpi = beautiful.xresources.apply_dpi

local clock_icon = helpers.ui.create_icon(config.icons.clock, theme.color.pink)

local clock = wibox.widget.textbox()
clock.font = helpers.ui.set_font("11")

gears.timer({
	timeout = 60,
	autostart = true,
	call_now = true,
	callback = function()
		clock.markup = os.date(config.widget.clock.format)
	end,
})

return wibox.widget({
	{
		clock_icon,
		clock,
		spacing = dpi(8),
		layout = wibox.layout.fixed.horizontal,
	},
	left = dpi(1),
	right = dpi(1),
	layout = wibox.container.margin,
})
