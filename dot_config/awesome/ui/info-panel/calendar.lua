local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")

local dpi = beautiful.xresources.apply_dpi
local theme = beautiful.get()

-- Creating Calendar
----------------------

-- copied from awesome doc and adjusted a bit
local styles = {}

styles.month = { bg_color = theme.color.surface0 }
styles.normal = {
	bg_color = theme.color.surface0,
	padding = dpi(6),
	fg_color = theme.color.subtext1,
}
styles.focus = {
	fg_color = theme.color.yellow,
	padding = dpi(6),
	markup = function(t)
		return "<b>" .. t .. "</b>"
	end,
}
styles.header = {
	fg_color = theme.color.blue,
	markup = function(t)
		return "<b>" .. t .. "</b>"
	end,
}
styles.weekday = {
	fg_color = theme.color.subtext1,
	markup = function(t)
		local f = helpers.ui.set_font("16")
		return '<span font_desc="' .. f .. '">' .. t .. "</span>"
	end,
}

-- The Function
local function decorate_cell(widget, flag)
	if flag == "monthheader" and not styles.monthheader then
		flag = "header"
	end

	local props = styles[flag] or {}

	if props.markup and widget.get_text and widget.set_markup then
		widget:set_markup(props.markup(widget:get_text()))
	end

	-- Change bg color for weekends
	local ret = wibox.widget({
		{
			widget,
			margins = props.padding,
			widget = wibox.container.margin,
		},
		fg = props.fg_color,
		bg = props.bg_color,
		widget = wibox.container.background,
	})

	return ret
end

local calendar = wibox.widget({
	date = os.date("*t"),
	font = helpers.ui.set_font("14"),
	fn_embed = decorate_cell,
	widget = wibox.widget.calendar.month,
})

return wibox.widget({
	nil,
	{
		nil,
		calendar,
		expand = "none",
		layout = wibox.layout.align.horizontal,
	},
	expand = "none",
	layout = wibox.layout.align.vertical,
})
