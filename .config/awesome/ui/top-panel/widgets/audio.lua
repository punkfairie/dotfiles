local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local awful = require("awful")

local helpers = require("helpers")

local dpi = beautiful.xresources.apply_dpi

-- Icon --
local icon = wibox.widget.textbox()
icon.font = beautiful.font_name .. "12.5"
icon.align = "center"
icon.markup = "<span foreground='" .. beautiful.color.blue .. "'>󰕾</span>"

-- Uptime --
local audio = wibox.widget.textbox()
audio.font = beautiful.font_name .. "10"
audio.align = "center"

local function get_val()
	awesome.connect_signal("signal::volume", function(vol, muted)
		if muted then
			audio.markup = "muted"
			icon.markup = "<span foreground='" .. beautiful.color.blue .. "'>󰖁</span>"
		else
			audio.markup = tonumber(vol) .. "%"
			icon.markup = "<span foreground='" .. beautiful.color.blue .. "'>󰕾</span>"
		end
	end)
end

get_val()

local full = wibox.widget({
	{
		{
			icon,
			audio,
			spacing = dpi(8),
			layout = wibox.layout.fixed.horizontal,
		},
		left = dpi(5),
		right = 8,
		layout = wibox.container.margin,
	},
	forced_width = 73,
	layout = wibox.layout.fixed.horizontal,
})

full:buttons(gears.table.join(awful.button({}, 1, function()
	awesome.emit_signal("action::toggle")
end)))

local update_volume = function()
	awful.spawn.easy_async_with_shell("pamixer --get-volume", function(stdout)
		audio.markup = tonumber(stdout:match("%d+")) .. "%"

		if tonumber(stdout:match("%d+")) < 10 then
			icon.markup = "<span foreground='" .. beautiful.xcolor2 .. "'>󰕿</span>"
		elseif tonumber(stdout:match("%d+")) < 50 then
			icon.markup = "<span foreground='" .. beautiful.xcolor2 .. "'>󰖀</span>"
		elseif tonumber(stdout:match("%d+")) < 100 then
			icon.markup = "<span foreground='" .. beautiful.xcolor2 .. "'>󰕾</span>"
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
