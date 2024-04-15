local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local config = require("config")

local dpi = beautiful.xresources.apply_dpi

-- Make Widgets
-----------------

-- Song's Title
local title = wibox.widget.textbox()
title.font = helpers.ui.set_font("Medium 16")
title.halign = "left"
title.valign = "bottom"

-- Song's Artist
local artist = wibox.widget.textbox()
artist.font = helpers.ui.set_font("Regular 16")
artist.halign = "left"
artist.valign = "bottom"

-- Song's Length
local length = wibox.widget.textbox()
length.font = helpers.ui.set_font("Regular 14")
length.halign = "center"
length.valign = "center"

-- Player's Button
local toggle = wibox.widget.textbox()
toggle.font = helpers.ui.set_font("26")

toggle:buttons(gears.table.join(awful.button({}, 1, function()
	awful.spawn("mpc toggle", false)

	if toggle.markup:match("󰏤") then
		toggle.markup = config.icons.music.play
	else
		toggle.markup = config.icons.music.pause
	end
end)))

local next = wibox.widget.textbox()
next.font = helpers.ui.set_font("26")
next.markup = config.icons.music.next

next:buttons(gears.table.join(awful.button({}, 1, function()
	awful.spawn("mpc next", false)
end)))

local back = wibox.widget.textbox()
back.font = helpers.ui.set_font("26")
back.markup = config.icons.music.prev

back:buttons(gears.table.join(awful.button({}, 1, function()
	awful.spawn("mpc prev", false)
end)))

-- Get data
awesome.connect_signal("signal::player", function(t, a, l, s)
	if not s:match("playing") then
		toggle.markup = config.icons.music.play
	else
		toggle.markup = config.icons.music.pause
	end

	title.markup = t
	artist.markup = a
	length.markup = l
end)

-- Grouping Widgets
---------------------

local buttons = wibox.widget({
	back,
	toggle,
	next,
	spacing = dpi(11),
	layout = wibox.layout.fixed.horizontal,
})

return wibox.widget({
	{
		nil,
		{
			title,
			artist,
			spacing = dpi(12),
			layout = wibox.layout.fixed.vertical,
		},
		expand = "none",
		layout = wibox.layout.align.vertical,
	},
	{
		nil,
		nil,
		{
			length,
			{
				nil,
				buttons,
				expand = "none",
				layout = wibox.layout.align.horizontal,
			},
			spacing = dpi(6),
			layout = wibox.layout.fixed.vertical,
		},
		top = dpi(30),
		bottom = 0,
		layout = wibox.container.margin,
	},
	layout = wibox.layout.flex.horizontal,
})
