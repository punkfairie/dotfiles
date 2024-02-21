local awful = require("awful")
local beautiful = require("beautiful").get()
local menu = require("main.menu")

local launcher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = menu })

return launcher
