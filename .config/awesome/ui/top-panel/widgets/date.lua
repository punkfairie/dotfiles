local gears = require("gears")
local wibox = require("wibox")
local helpers = require("helpers")
local beautiful = require("beautiful")
local config = require("config")

local theme = beautiful.get()
local dpi = beautiful.xresources.apply_dpi

local icon = helpers.ui.create_icon(config.icons.cal, theme.xcolor5)

local date = wibox.widget.textbox()
date.font = helpers.ui.set_font("11")

gears.timer({
	timeout = 60,
	autostart = true,
	call_now = true,
	callback = function()
		date.markup = os.date(config.widget.date.format)
	end,
})

return wibox.widget({
	{
		icon,
		date,
		spacing = dpi(8),
		layout = wibox.layout.fixed.horizontal,
	},
	left = dpi(1),
	right = dpi(1),
	layout = wibox.container.margin,
})
