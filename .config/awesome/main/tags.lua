local awful = require("awful")
local icons = require("config").theme.icons.tags

screen.connect_signal("request::desktop_decoration", function(s)
	awful.tag(
		{ icons.general, icons.files, icons.media, icons.terminal, icons.coding, icons.misc },
		s,
		awful.layout.layouts[1]
	)
end)
