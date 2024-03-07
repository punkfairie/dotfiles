local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local rubato = require("lib.rubato")

local dpi = beautiful.xresources.apply_dpi
local theme = beautiful.get()

-- Var
local width = dpi(410)
local height = awful.screen.focused().geometry.height - dpi(100)

-- Helper
-----------

local function round_widget(radius)
	return function(cr, w, h)
		gears.shape.rounded_rect(cr, w, h, radius)
	end
end

local function box_widget(widgets, _width, _height)
	return wibox.widget({
		{
			{
				widgets,
				margins = dpi(16),
				widget = wibox.container.margin,
			},
			forced_width = dpi(_width),
			forced_height = dpi(_height),
			shape = round_widget(8),
			bg = theme.bg_focus, --for widget Rounded and Border
			widget = wibox.container.background,
		},
		margins = { left = dpi(20), right = dpi(20) },
		widget = wibox.container.margin,
	})
end

-- Get widgets
local weather_widget = require("ui.info-panel.weather")
local profile_widget = require("ui.info-panel.profile")

local calendar_widget = require("ui.info-panel.calendar")
local music_widget = require("ui.info-panel.music-player")

-- Combine some widgets
local weather = box_widget(weather_widget, 380, 180)
local profile = box_widget(profile_widget, 380, 210)
local calendar = box_widget(calendar_widget, 380, 340)

-- Sidebar
local sidebar = wibox({
	visible = false,
	ontop = true,
	width = width,
	height = height,
	y = dpi(60),
	bg = theme.bg_normal,
	border_width = theme.border_width * 2,
	border_color = theme.border_normal,
})

-- Sidebar widget setup
sidebar:setup({
	{
		profile,
		music_widget,
		weather,
		calendar,
		spacing = dpi(20),
		layout = wibox.layout.fixed.vertical,
	},
	margins = { top = dpi(20), bottom = dpi(20) },
	widget = wibox.container.margin,
})

-- Slide animation
local slide = rubato.timed({
	pos = awful.screen.focused().geometry.x - sidebar.width,
	rate = 60,
	intro = 0.2,
	duration = 0.4,
	subscribed = function(pos)
		sidebar.x = awful.screen.focused().geometry.x + pos
	end,
})

-- Timer of sidebar's death
sidebar.timer = gears.timer({
	timeout = 0.5,
	single_shot = true,
	callback = function()
		sidebar.visible = not sidebar.visible
	end,
})

sidebar.shape = function(cr, w, h) --Rounded Corners
	gears.shape.rounded_rect(cr, w, h, 14)
end

-- Toggle function
sidebar.toggle = function()
	if sidebar.visible then
		slide.target = awful.screen.focused().geometry.x - sidebar.width
		sidebar.timer:start()
	else
		awesome.emit_signal("widget::update_uptime")
		slide.target = awful.screen.focused().geometry.x + dpi(20)
		sidebar.visible = not sidebar.visible
	end
end

-- Get signal to execute the function (if that makes sense)
awesome.connect_signal("sidebar::toggle", function()
	sidebar.toggle()
end)

return sidebar
