local beautiful = require("beautiful")

local theme = beautiful.get()
local dpi = beautiful.xresources.apply_dpi

local M = {
	margin = theme.useless_gap * 2,
	padding = theme.useless_gap / 1.5,
}

M.height = (M.padding * 2) + dpi(20)

return M
