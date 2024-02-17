local awful = require("awful")
local bling = require("lib.bling")
local machi = require("lib.layout-machi")

machi.editor.nested_layouts = {
	["0"] = bling.layout.deck,
	["1"] = awful.layout.suit.spiral,
	["2"] = awful.layout.suit.fair,
	["3"] = awful.layout.suit.fair.horizontal,
}

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.spiral.dwindle,
	awful.layout.suit.floating,
	awful.layout.suit.max,
	bling.layout.centered,
	bling.layout.mstab,
	bling.layout.equalarea,
	machi.default_layout,
}

client.connect_signal("manage", function(c)
	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)
