local awful = require("awful")
local wibox = require("wibox")
local widgets = require("ui.top-panel.widgets")
local beautiful = require("beautiful")
local vars = require("ui.top-panel.config")

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

	local layoutbox = awful.widget.layoutbox({
		screen = s,
		buttons = {
			awful.button({}, 1, function()
				awful.layout.inc(1)
			end),

			awful.button({}, 3, function()
				awful.layout.inc(-1)
			end),

			awful.button({}, 4, function()
				awful.layout.inc(-1)
			end),

			awful.button({}, 5, function()
				awful.layout.inc(1)
			end),
		},
	})

	-- Create the wibox
	s.mywibox = awful.wibar({
		position = "top",
		screen = s,
		margins = {
			top = vars.margin,
			right = vars.margin,
			left = vars.margin,
		},
		border_width = theme.border_width,
		border_color = theme.border_normal,
		height = vars.height,

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
				left = theme.useless_gap,
				right = 0,
				top = vars.padding,
				bottom = vars.padding,
				layout = wibox.container.margin,
			},
			{
				{
					layout = wibox.layout.align.horizontal,
					clockdate,
				},
				left = 0,
				right = 0,
				top = vars.padding,
				bottom = vars.padding,
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
					layoutbox,
				},
				left = 0,
				right = theme.useless_gap,
				top = vars.padding,
				bottom = vars.padding,
				layout = wibox.container.margin,
			},
		},
	})
end)
