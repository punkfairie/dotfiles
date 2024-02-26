local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local helpers = require("helpers")
local config = require("config")

local theme = beautiful.get()
local dpi = beautiful.xresources.apply_dpi

local os_user = os.getenv("USER")

if not os_user then
	os_user = "user"
end

-- Create Widgets
-------------------

-- Pfp
local pfp = wibox.widget.imagebox()
pfp.image = require("config").theme.pfp
pfp.clip_shape = gears.shape.circle
pfp.forced_width = dpi(130)
pfp.forced_height = dpi(130)

-- User
local user = wibox.widget.textbox()
user.font = helpers.ui.set_font("SemiBold 18")
user.align = "left"
user.markup = helpers.ui.colorize_text(os_user, theme.fg_normal)

-- Hostname
local hostname = wibox.widget.textbox()
hostname.font = helpers.ui.set_font("Regular 14")
hostname.align = "left"

awful.spawn.easy_async_with_shell("hostnamectl --static", function(stdout)
	hostname.markup = helpers.ui.colorize_text("@" .. tostring(stdout), theme.color.lavender)
end)

-- Battery
local uptimeosd = wibox.widget.textbox()
uptimeosd.font = helpers.ui.set_font("12")
uptimeosd.align = "center"

-- Get data 4 widgets!
awesome.connect_signal("signal::uptime", function(uptime)
	uptimeosd.markup = helpers.ui.colorize_text("up " .. uptime, theme.fg_normal)
end)

-- Spacing horizontally
local shutdown = wibox.widget({
	{
		{
			font = helpers.ui.set_font("30"),
			markup = helpers.ui.colorize_text(config.icons.power, theme.color.red),
			align = "center",
			valign = "center",
			widget = wibox.widget.textbox,
		},
		top = dpi(9),
		bottom = dpi(9),
		left = dpi(11),
		right = dpi(11),
		widget = wibox.container.margin,
	},
	bg = theme.color.surface1,
	shape = helpers.ui.rrect(8),
	widget = wibox.container.background,
})

local reboot = wibox.widget({
	{
		{
			font = helpers.ui.set_font("30"),
			markup = helpers.ui.colorize_text(config.icons.restart, theme.color.blue),
			align = "center",
			valign = "center",
			widget = wibox.widget.textbox,
		},
		top = dpi(9),
		bottom = dpi(9),
		left = dpi(11),
		right = dpi(11),
		widget = wibox.container.margin,
	},
	bg = theme.color.surface1,
	shape = helpers.ui.rrect(8),
	widget = wibox.container.background,
})
shutdown:connect_signal("mouse::enter", function()
	shutdown.bg = theme.color.surface2
end)

shutdown:connect_signal("mouse::leave", function()
	shutdown.bg = theme.color.surface1
end)

reboot:connect_signal("mouse::enter", function()
	reboot.bg = theme.color.surface2
end)

reboot:connect_signal("mouse::leave", function()
	reboot.bg = theme.color.surface1
end)

shutdown:buttons(gears.table.join(awful.button({}, 1, function()
	awesome.emit_signal("module::exit_screen:show")
end)))

reboot:buttons(gears.table.join(awful.button({}, 1, function()
	awful.spawn.with_shell("loginctl reboot")
end)))

-- Grouping widgets
---------------------
local buttons = wibox.widget({
	{
		reboot,
		shutdown,
		spacing = dpi(8),
		layout = wibox.layout.fixed.horizontal,
	},
	top = dpi(10),
	left = dpi(57),
	widget = wibox.container.margin,
})

local name = wibox.widget({
	{
		user,
		hostname,
		spacing = dpi(4),
		layout = wibox.layout.fixed.vertical,
	},
	left = 0,
	widget = wibox.container.margin,
})

local uptimebox = wibox.widget({
	{
		{
			uptimeosd,
			spacing = dpi(2),
			layout = wibox.layout.fixed.vertical,
		},
		top = dpi(3),
		bottom = dpi(3),
		widget = wibox.container.margin,
	},
	bg = theme.color.surface0,
	shape = helpers.ui.rrect(7),
	widget = wibox.container.background,
})

-- The Profile Widget
return wibox.widget({
	{
		{
			pfp,
			uptimebox,
			spacing = dpi(20),
			layout = wibox.layout.fixed.vertical,
		},
		layout = wibox.layout.fixed.vertical,
	},
	{
		{
			name,
			buttons,
			layout = wibox.layout.fixed.vertical,
		},
		top = dpi(30),
		layout = wibox.container.margin,
	},
	spacing = dpi(30),
	layout = wibox.layout.fixed.horizontal,
})
