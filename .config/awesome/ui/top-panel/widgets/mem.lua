local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- Icon
local icon = wibox.widget.textbox()
icon.font = beautiful.font_name .. "12.5"
icon.align = "center"
icon.markup = "<span foreground='" .. beautiful.xcolor6 .. "'>󰍛</span>"

-- Uptime
local mem = wibox.widget.textbox()
mem.font = beautiful.font_name .. "10"
mem.align = "center"

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
		left = 1,
		right = 0,
		layout = wibox.container.margin,
	},
	forced_width = 73,
	layout = wibox.layout.fixed.horizontal,
})

return full
