local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful").get()
require("awful.hotkeys_popup.keys")

-- Clock

local clock = wibox.widget.textbox()
clock.font = beautiful.font_name .. "11"
gears.timer({
	timeout = 60,
	autostart = true,
	call_now = true,
	callback = function()
		clock.markup = os.date(" %I:%M %p")
	end,
})

return clock