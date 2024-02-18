local beautiful = require("beautiful")
local wibox = require("wibox")
local awful = require("awful")

local widgets = require("ui.top-panel.widgets")

local dpi = beautiful.xresources.apply_dpi

local function create_icon(i, c)
	local widget = {
		{
			font = beautiful.font_name .. "12.5",
			text = " " .. i,
			widget = wibox.widget.textbox,
		},
		fg = c,
		widget = wibox.container.background,
	}

	return widget
end

-- Create icons with color.
local calendar_icon = create_icon("", beautiful.color.teal)
local clock_icon = create_icon(" ", beautiful.color.pink)

screen.connect_signal("request::desktop_decoration", function(s)
	local clockdate = wibox.widget({
		layout = wibox.layout.fixed.horizontal,
		calendar_icon,
		widgets.date,
		clock_icon,
		widgets.clock,
	})

	local tasklist = wibox.widget({
		{
			layout = wibox.layout.fixed.horizontal,
			s.tasklist,
		},
		forced_width = 300,
		layout = wibox.layout.fixed.horizontal,
	})

	-- Create the wibox.
	s.wibox = awful.wibar({
		position = "top",
		screen = s,
		margins = {
			top = dpi(10),
			left = dpi(20),
			right = dpi(20),
		},
		border_width = dpi(2),
		border_color = beautiful.color.surface0,

		widget = {
			layout = wibox.layout.align.horizontal,
			expand = "none",
			{
				{ -- left widgets
					layout = wibox.layout.fixed.horizontal,
					widgets.menu,
					widgets.seperator,
					s.taglist,
					widgets.seperator,
					tasklist,
				},
				left = 5,
				right = 0,
				top = 2,
				bottom = 2,
				layout = wibox.container.margin,
			},
			{
				{
					layout = wibox.layout.align.horizontal,
					clockdate,
				},
				left = 0,
				right = 0,
				top = 1,
				bottom = 1,
				layout = wibox.container.margin,
			},
			{ -- right widgets
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
				right = 2,
				top = 1,
				bottom = 1,
				layout = wibox.container.margin,
			},
		},
	})

	-- s.border2 = awful.wibar({
	-- 	position = "top",
	-- 	screen = s,
	-- 	bg = beautiful.color.surface0,
	-- 	height = dpi(2),
	-- })
end)
