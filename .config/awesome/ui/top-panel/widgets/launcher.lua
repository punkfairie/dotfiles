local awful = require("awful")
local beautiful = require("beautiful")

local mainmenu = require("ui.menu").mainmenu

local launcher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mainmenu })

return launcher
