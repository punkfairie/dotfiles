local awful = require("awful")
local wibox = require("wibox")

local image = require("config").theme.wallpaper

local function set_wall(s)
	awful.wallpaper({
		screen = s,
		widget = {
			{
				image = image,
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
