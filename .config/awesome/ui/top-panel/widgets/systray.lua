local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local rubato = require("lib.rubato")
local helpers = require("helpers")
local config = require("config")

local theme = beautiful.get()
local dpi = beautiful.xresources.apply_dpi

local arrow = wibox.widget.textbox()
arrow.font = helpers.ui.set_font("13")
arrow.markup = config.icons.arr.r

local systray = wibox.widget.systray()
systray.visible = true
theme.systray_icon_spacing = dpi(4)

local sys = wibox.widget({
	widget = wibox.container.constraint,
	strategy = "max",
	visible = true,
	width = 0,
	{
		widget = wibox.container.margin,
		margins = dpi(2),
		systray,
	},
})

local slide = rubato.timed({
	duration = 0.9,
	awestore_compat = true,
	subscribed = function(pos)
		sys.width = pos
	end,
})

local value = true

arrow.toggle = function()
	if value == false then
		arrow.markup = config.icons.arr.r
		value = true
		slide:set(2)
	else
		arrow.markup = config.icons.arr.l
		slide:set(500)
		value = false
	end
end

arrow:add_button(awful.button({}, 1, function()
	arrow.toggle()
end))

local full = wibox.widget({
	layout = wibox.layout.fixed.horizontal,
	arrow,
	sys,
	spacing = dpi(2),
})

return full
