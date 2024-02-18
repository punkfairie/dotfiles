local awful = require("awful")
local ruled = require("ruled")
local dpi = require("beautiful.xresources").apply_dpi

local apps = require("config").apps
local helpers = require("helpers")

ruled.client.connect_signal("request::rules", function()
	ruled.client.append_rule({
		id = "global",
		rule = {},
		properties = {
			focus = awful.client.focus.filter,
			raise = true,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
		},
	})

	ruled.client.append_rule({
		id = "titlebars",
		rule_any = { type = { "normal", "dialog" } },
		properties = { titlebars_enabled = true },
	})

	ruled.client.append_rule({
		rule = { class = apps["launcher"] },
		properties = { titlebars_enabled = false },
	})

	ruled.client.append_rule({
		rule = { instance = "origin.exe" },
		properties = {
			floating = true,
			titlebars_enabled = false,
			border_width = dpi(0),
			shape = helpers.ui.rrect(0),
		},
	})

	ruled.client.append_rule({
		rule = { instance = "wine" },
		properties = { shape = helpers.ui.rrect(0), titlebars_enabled = false },
	})

	ruled.client.append_rule({
		rule_any = { floating = true },
		properties = { placement = awful.placement.centered, ontop = true },
	})

	ruled.client.append_rule({
		rule_any = { class = { "xfce" }, instance = { "xfce" } },
		properties = { floating = true },
	})
end)
