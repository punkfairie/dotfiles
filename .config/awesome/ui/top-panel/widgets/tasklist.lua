local awful = require("awful")

awful.screen.connect_for_each_screen(function(s)
	s.tasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.focused,
	})
end)
