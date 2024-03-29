local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")

local theme = beautiful.get()
local dpi = beautiful.xresources.apply_dpi

local slider = wibox.widget({
	bar_shape = helpers.ui.rrect(9),
	bar_height = 6,
	bar_color = theme.bg_focus,
	bar_active_color = theme.color.yellow,
	handle_shape = gears.shape.circle,
	handle_color = theme.color.yellow,
	handle_width = dpi(12),
	value = dpi(25),
	widget = wibox.widget.slider,
})

helpers.ui.add_hover_cursor(slider, "hand1")

local bri_slider = wibox.widget({
	{
		markup = helpers.ui.colorize_text("󰃞 ", theme.color.yellow),
		font = helpers.ui.set_font("14"),
		halign = "center",
		valign = "center",
		widget = wibox.widget.textbox(),
	},
	slider,
	layout = wibox.layout.fixed.horizontal,
	spacing = 0,
})

awful.spawn.easy_async_with_shell(
	"brightnessctl | grep -i  'current' | awk '{ print $4}' | tr -d \"(%)\"",
	function(stdout)
		local value = string.gsub(stdout, "^%s*(.-)%s*$", "%1")
		bri_slider.value = tonumber(value)
	end
)

slider:connect_signal("property::value", function(_, new_value)
	slider.value = new_value
	awful.spawn("brightnessctl set " .. new_value .. "%", false)
end)

return bri_slider
