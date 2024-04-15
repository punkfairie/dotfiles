local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers.ui")
local config = require("config")

local theme = beautiful.get()
local dpi = beautiful.xresources.apply_dpi

-- Icon
local icon = helpers.create_icon(config.icons.cpu, theme.color.maroon)

-- Uptime
local cpu = wibox.widget.textbox()
cpu.font = helpers.set_font("10")
cpu.halign = "center"

local function get_val()
	awesome.connect_signal("signal::cpu", function(cpu_perc)
		if cpu_perc then
			cpu_perc = tonumber(cpu_perc)
		else
			cpu_perc = "?"
		end

		cpu.markup = cpu_perc .. "%"
	end)
end

get_val()

local full = wibox.widget({
	{
		{
			icon,
			cpu,
			spacing = dpi(8),
			layout = wibox.layout.fixed.horizontal,
		},
		left = dpi(1),
		right = 0,
		layout = wibox.container.margin,
	},
	forced_width = dpi(73), -- Makes it fixed and not Moves Whole Bar
	layout = wibox.layout.fixed.horizontal,
})

return full
