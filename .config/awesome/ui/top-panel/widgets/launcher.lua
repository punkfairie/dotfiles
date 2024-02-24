local awful = require("awful")
local theme = require("beautiful").get()
local menu = require("main.menu")

local launcher = awful.widget.launcher({ image = theme.awesome_icon, menu = menu })

return launcher
