local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers.ui")
local config = require("config")

local theme = beautiful.get()
local dpi = beautiful.xresources.apply_dpi

-- Icon
local icon = helpers.create_icon(config.icons.disk, theme.color.yellow)

-- Uptime
local disk = wibox.widget.textbox()
disk.font = helpers.set_font("10")
disk.halign = "center"

local function get_val()
	awesome.connect_signal("signal::disk", function(disk_perc)
		if disk_perc then
			disk.markup = tonumber(disk_perc) .. "%"
		end
	end)
end

get_val()

local full = wibox.widget({
	{
		icon,
		disk,
		spacing = dpi(8),
		layout = wibox.layout.fixed.horizontal,
	},
	left = dpi(1),
	right = dpi(8),
	layout = wibox.container.margin,
})

return full
