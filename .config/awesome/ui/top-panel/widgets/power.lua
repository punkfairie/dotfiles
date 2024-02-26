local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local config = require("config")
local helpers = require("helpers")

local theme = beautiful.get()

-- Menu
local menu = wibox.widget.textbox()
menu.font = helpers.ui.set_font("16")
menu.markup = helpers.ui.colorize_text(config.icons.power, theme.color.red)

menu:add_button(awful.button({}, 1, function()
	awesome.emit_signal("module::exit_screen:show")
end))

return menu
