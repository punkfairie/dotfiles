local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")

local dpi = xresources.apply_dpi

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
	-- buttons for the titlebar
	local buttons = gears.table.join(
		awful.button({}, 1, function()
			c:activate({ context = "titlebar", action = "mouse_move" })
		end),

		awful.button({}, 3, function()
			c:activate({ context = "titlebar", action = "mouse_resize" })
		end)
	)

	local titlebar_top = awful.titlebar(c, {
		size = 30,
		expand = "none",
	})

	local left = {
		buttons = buttons,
		layout = wibox.layout.fixed.horizontal(),
	}

	local middle = {
		buttons = buttons,
		layout = wibox.layout.fixed.horizontal(),
	}

	local right = {
		awful.titlebar.widget.maximizedbutton(c),
		awful.titlebar.widget.minimizebutton(c),
		awful.titlebar.widget.closebutton(c),
		spacing = dpi(11.5),
		layout = wibox.layout.fixed.horizontal(),
	}

	titlebar_top:setup({
		{
			left,
			middle,
			right,
			layout = wibox.layout.align.horizontal(),
		},
		left = dpi(13.5),
		right = dpi(13.5),
		top = dpi(7.4),
		bottom = dpi(7.4),
		layout = wibox.container.margin,
	})
end)
