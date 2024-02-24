local beautiful = require("beautiful")
local wibox = require("wibox")
local helpers = require("helpers")

local theme = beautiful.get()

local seperator = wibox.widget.textbox()

seperator.font = helpers.ui.set_font("14")
seperator.markup = helpers.ui.colorize_text("|", theme.xcolorT2)

return seperator
