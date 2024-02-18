local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

local date = wibox.widget.textbox()
date.font = beautiful.font_name .. "11"

gears.timer({
	timeout = 60,
	autostart = true,
	call_now = true,
	callback = function()
		date.markup = os.date(" %a %b %d")
	end,
})

return date
