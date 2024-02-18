local wibox = require("wibox")
local beautiful = require("beautiful")

local seperator = wibox.widget.textbox()
seperator.font = beautiful.font_name .. "14"
seperator.markup = "<span foreground='" .. beautiful.color.subtext1 .. "'>|</span>"

return seperator
