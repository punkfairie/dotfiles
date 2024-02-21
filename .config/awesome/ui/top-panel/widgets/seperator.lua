local beautiful = require("beautiful").get()
local wibox = require("wibox")

local seperator = wibox.widget.textbox()

seperator.font = beautiful.font_name .. "14"
seperator.markup = "<span foreground='" .. beautiful.xcolorT2 .. "'>|</span>"

return seperator
