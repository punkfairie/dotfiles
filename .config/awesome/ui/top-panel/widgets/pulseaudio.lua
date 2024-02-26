local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local config = require("config")

local theme = beautiful.get()
local dpi = beautiful.xresources.apply_dpi

-- Icon
local icon = helpers.ui.create_icon(config.icons.vol.on, theme.color.blue)

-- Uptime
local pulseaudio = wibox.widget.textbox()
pulseaudio.font = helpers.ui.set_font("10")
pulseaudio.align = "center"

local function get_val()
	awesome.connect_signal("signal::volume", function(vol, muted)
		if muted then
			pulseaudio.markup = "muted"
			icon.markup = helpers.ui.colorize_text(config.icons.vol.off, theme.color.blue)
		else
			pulseaudio.markup = tonumber(vol) .. "%"
			icon.markup = helpers.ui.colorize_text(config.icons.vol.on, theme.color.blue)
		end
	end)
end

get_val()

local full = wibox.widget({
	{
		{
			icon,
			pulseaudio,
			spacing = dpi(8),
			layout = wibox.layout.fixed.horizontal,
		},
		left = dpi(5),
		right = dpi(8),
		layout = wibox.container.margin,
	},
	forced_width = dpi(73),
	layout = wibox.layout.fixed.horizontal,
})

full:add_button(awful.button({}, 1, function()
	awesome.emit_signal("action::toggle")
end))

-- Update Function
local update_volume = function()
	awful.spawn.easy_async_with_shell("pamixer --get-volume", function(stdout)
		pulseaudio.markup = tonumber(stdout:match("%d+")) .. "%"

		if tonumber(stdout:match("%d+")) < 10 then
			icon.markup = helpers.ui.colorize_text(config.icons.vol.low, theme.color.blue)
		elseif tonumber(stdout:match("%d+")) < 50 then
			icon.markup = helpers.ui.colorize_text(config.icons.vol.med, theme.color.blue)
		elseif tonumber(stdout:match("%d+")) < 100 then
			icon.markup = helpers.ui.colorize_text(config.icons.vol.high, theme.color.blue)
		else
		end
	end)
end

update_volume()

awesome.connect_signal("widget::update_vol", function()
	update_volume()
end)

awesome.connect_signal("widget::update_vol_pulse", function()
	update_volume()
end)

helpers.ui.add_hover_cursor(full, "hand2")

return full
