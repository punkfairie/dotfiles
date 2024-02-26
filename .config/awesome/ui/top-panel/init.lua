local awful = require("awful")
local wibox = require("wibox")
local widgets = require("ui.top-panel.widgets")
local beautiful = require("beautiful")

local theme = beautiful.get()
local dpi = beautiful.xresources.apply_dpi

screen.connect_signal("request::desktop_decoration", function(s)
	local clockdate = wibox.widget({
		layout = wibox.layout.fixed.horizontal,
		widgets.date,
		widgets.clock,
	})

	local tasklist = wibox.widget({
		{
			layout = wibox.layout.fixed.horizontal,
			s.tasklist, -- needs to be here (under the screen.connect_signal) bc of the s
		},
		forced_width = dpi(300),
		layout = wibox.layout.fixed.horizontal,
	})

	-- Create the wibox
	s.mywibox = awful.wibar({
		position = "top",
		screen = s,

		widget = {
			layout = wibox.layout.align.horizontal,
			expand = "none",
			{
				{ -- Left widgets
					layout = wibox.layout.fixed.horizontal,
					widgets.menu,
					widgets.seperator,
					s.taglist,
					widgets.seperator,
					tasklist,
				},
				left = dpi(5),
				right = 0,
				top = dpi(2),
				bottom = dpi(2),
				layout = wibox.container.margin,
			},
			{
				{
					layout = wibox.layout.align.horizontal,
					clockdate,
				},
				left = 0,
				right = 0,
				top = dpi(1),
				bottom = dpi(1),
				layout = wibox.container.margin,
			},
			{ -- Right widgets
				{
					layout = wibox.layout.fixed.horizontal,
					widgets.systray,
					widgets.seperator,
					widgets.audio,
					widgets.mem,
					widgets.cpu,
					widgets.disk,
					widgets.layoutbox,
				},
				left = 0,
				right = dpi(2),
				top = dpi(1),
				bottom = dpi(1),
				layout = wibox.container.margin,
			},
		},
	})

	s.border2 = awful.wibar({
		position = "top",
		screen = s,
		bg = theme.color.surface0,
		height = dpi(2),
	})
end)
