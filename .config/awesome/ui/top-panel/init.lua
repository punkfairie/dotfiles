-- Standard awesome library --
local awful = require("awful")
local wibox = require("wibox")
local widgets = require("ui.top-panel.widgets")
local beautiful = require("beautiful")

local dpi = beautiful.xresources.apply_dpi

local clock = widgets.clock
local date = widgets.date
local cpu = widgets.cpu
local disk = widgets.disk
local keyboard = widgets.keyboard
local mem = widgets.mem
local menu = widgets.menu
local systray = widgets.systray
local audio = widgets.audio
local seperator = widgets.seperator
local layoutbox = widgets.layoutbox

local function create_icon(i, c) --Icon Creation
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

-- Create Icons with Color --
local calendar_icon = create_icon("", beautiful.xcolor5)
local clock_icon = create_icon("", beautiful.xcolor12)
local keyboard_icon = create_icon("", beautiful.xcolor4)

screen.connect_signal("request::desktop_decoration", function(s)
	-- Create Clock with Colerfull Widget --
	local clockdate = wibox.widget({
		layout = wibox.layout.fixed.horizontal,
		calendar_icon,
		date,
		clock_icon,
		clock, -- Middle widget
	})

	local tasklist = wibox.widget({
		{
			layout = wibox.layout.fixed.horizontal,
			s.tasklist, -- needs to be here (under the screen.connect_signal) bc of the s
		},
		forced_width = 300,
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
					menu,
					seperator,
					s.taglist,
					seperator,
					tasklist,
				},
				left = 5, --Padding
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
			{ -- Right widgets
				{
					layout = wibox.layout.fixed.horizontal,
					systray,
					seperator,
					audio,
					mem,
					cpu,
					disk,
					keyboard_icon,
					keyboard,
					layoutbox,
				},
				left = 0,
				right = 2,
				top = 1,
				bottom = 1,
				layout = wibox.container.margin,
			},
		},
	})
	s.border2 = awful.wibar({
		position = "top",
		screen = s,
		bg = beautiful.xcolorS0,
		height = dpi(2),
	})
end)

