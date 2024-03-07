local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")

local theme = beautiful.get()
local dpi = beautiful.xresources.apply_dpi

local slider = wibox.widget({
	bar_shape = helpers.ui.rrect(9),
	bar_height = dpi(6),
	bar_color = theme.color.base,
	bar_active_color = theme.color.blue,
	handle_shape = gears.shape.circle,
	handle_color = theme.color.blue,
	handle_width = dpi(12),
	value = dpi(75),
	forced_width = dpi(239),
	widget = wibox.widget.slider,
})

local osd_value = wibox.widget({
	text = "0%",
	font = helpers.ui.set_font("10"),
	widget = wibox.widget.textbox(),
})
local icon = wibox.widget({
	markup = helpers.ui.colorize_text("󰕾 ", theme.color.blue),
	font = helpers.ui.set_font("14"),
	halign = "center",
	valign = "center",
	widget = wibox.widget.textbox(),
})

local function get_val()
	awesome.connect_signal("signal::volume", function(_, muted)
		if muted then
			icon.markup = helpers.ui.colorize_text("󰖁", theme.color.blue)
		else
			icon.markup = helpers.ui.colorize_text("󰕾", theme.color.blue)
		end
	end)
end

get_val()

icon:buttons(gears.table.join(awful.button({}, 1, function()
	local script = "pamixer -t"

	awful.spawn(script, false)
	awesome.emit_signal("widget::update_vol")
end)))

slider:buttons(gears.table.join(
	awful.button({}, 4, nil, function()
		if slider:get_value() > 100 then
			slider:set_value(100)
			return
		end
		slider:set_value(slider:get_value() + 5)
	end),

	awful.button({}, 5, nil, function()
		if slider:get_value() < 0 then
			slider:set_value(0)
			return
		end
		slider:set_value(slider:get_value() - 5)
	end)
))

helpers.ui.add_hover_cursor(slider, "hand1")
helpers.ui.add_hover_cursor(icon, "hand2")

local vol_slider = wibox.widget({
	{
		{
			layout = wibox.layout.fixed.horizontal,
			icon,
		},
		left = 0,
		right = dpi(14),
		top = dpi(5),
		bottom = dpi(5),
		layout = wibox.container.margin,
	},
	slider,
	layout = wibox.layout.fixed.horizontal,
	{
		{
			layout = wibox.layout.fixed.horizontal,
			osd_value,
		},
		left = dpi(3),
		right = 0,
		top = 0,
		bottom = 0,
		layout = wibox.container.margin,
	},
})

local update_volume = function() -- Sets the Volume Correct
	awful.spawn.easy_async_with_shell("pamixer --get-volume", function(stdout)
		slider.value = tonumber(stdout:match("%d+"))
	end)
end

awesome.connect_signal("widget::update_vol", function()
	update_volume()
end)

awesome.connect_signal("widget::update_vol_slider", function(volume_level)
	slider:set_value(volume_level)
end)

slider:connect_signal("property::value", function(_, new_value)
	awful.spawn("pamixer --set-volume " .. new_value, false)
	awesome.emit_signal("widget::update_vol_pulse") -- update_vol_pulse doesn't Update Volume Signal
	local volume_level = slider:get_value()
	osd_value.text = volume_level .. "%"
end)

return vol_slider
