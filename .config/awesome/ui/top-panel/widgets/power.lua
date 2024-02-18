local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local awful = require("awful")

local menu = wibox.widget.textbox()
menu.font = beautiful.font_name .. "16"
menu.markup = "<span foreground='" .. beautiful.color.red .. "'></span>"

menu:buttons(gears.table.join(awful.button({}, 1, function()
	awesome.emit_signal("module::exit_screen:show")
end)))

return menu
