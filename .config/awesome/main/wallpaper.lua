local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

local function set_wall(s)
	awful.wallpaper({
		screen = s,
		widget = {
			{
				image = beautiful.wallpaper,
				upscale = true,
				downscale = true,
				widget = wibox.widget.imagebox,
			},
			valign = "center",
			halign = "center",
			tiled = true,
			widget = wibox.container.tile,
		},
	})
end

screen.connect_signal("request::wallpaper", function(s)
	set_wall(s)
end)
