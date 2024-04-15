local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers.ui")
local config = require("config")

local theme = beautiful.get()
local dpi = beautiful.xresources.apply_dpi

-- Icon
local icon = helpers.create_icon(config.icons.mem, theme.color.green)

-- Uptime
local mem = wibox.widget.textbox()
mem.font = helpers.set_font("10")
mem.halign = "center"

local function get_val()
	awesome.connect_signal("signal::mem", function(mem_perc)
		mem.markup = tonumber(mem_perc) .. "%"
	end)
end

get_val()

local full = wibox.widget({
	{
		{
			icon,
			mem,
			spacing = dpi(8),
			layout = wibox.layout.fixed.horizontal,
		},
		left = dpi(1),
		right = 0,
		layout = wibox.container.margin,
	},
	forced_width = dpi(73),
	layout = wibox.layout.fixed.horizontal,
})

return full
