local gears = require("gears")
local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local helpers = require("helpers")
local menubar = require("menubar")
local animation = require("lib.animation")

local theme = beautiful.get()
local dpi = beautiful.xresources.apply_dpi

--- Naughty Notifications with animation
--- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

naughty.persistence_enabled = true
naughty.config.defaults.ontop = true
naughty.config.defaults.timeout = 6
naughty.config.defaults.title = "System Notification"
naughty.config.defaults.position = "top_right"

local function get_oldest_notification()
	for _, notification in ipairs(naughty.active) do
		if notification and notification.timeout > 0 then
			return notification
		end
	end

	--- Fallback to first one.
	return naughty.active[1]
end

--- Handle notification icon
naughty.connect_signal("request::icon", function(n, context, hints)
	--- Handle other contexts here
	if context ~= "app_icon" then
		return
	end

	--- Use XDG icon
	local path = menubar.utils.lookup_icon(hints.app_icon) or menubar.utils.lookup_icon(hints.app_icon:lower())

	if path then
		n.icon = path
	end
end)

--- Use XDG icon
naughty.connect_signal("request::action_icon", function(a, _, hints)
	a.icon = menubar.utils.lookup_icon(hints.id)
end)

naughty.connect_signal("request::display", function(n)
	--- random accent color
	local accent_colors = theme.color.accent

	--- table of icons
	local app_icons = {
		["firefox"] = { icon = "" },
		["discord"] = { icon = "󰙯" },
		["music"] = { icon = "󰝚" },
		["screenshot tool"] = { icon = "󰊓" },
	}

	local app_icon = nil
	local tolow = string.lower

	if app_icons[tolow(n.app_name)] then
		app_icon = app_icons[tolow(n.app_name)].icon
	else
		app_icon = "󰂚"
	end

	local app_icon_n = wibox.widget({
		{
			font = helpers.ui.set_font("Round 13"),
			markup = helpers.ui.colorize_text(app_icon, theme.color.base),
			halign = "center",
			valign = "center",
			widget = wibox.widget.textbox,
		},
		bg = accent_colors,
		widget = wibox.container.background,
		shape = gears.shape.circle,
		forced_height = dpi(20),
		forced_width = dpi(20),
	})

	local icon = wibox.widget({
		{
			{
				{
					image = n.icon,
					resize = true,
					clip_shape = gears.shape.circle,
					halign = "center",
					valign = "center",
					widget = wibox.widget.imagebox,
				},
				border_width = dpi(2),
				border_color = accent_colors,
				shape = gears.shape.circle,
				widget = wibox.container.background,
			},
			strategy = "exact",
			height = dpi(50),
			width = dpi(50),
			widget = wibox.container.constraint,
		},
		{
			nil,
			nil,
			{
				nil,
				nil,
				app_icon_n,
				layout = wibox.layout.align.horizontal,
				expand = "none",
			},
			layout = wibox.layout.align.vertical,
			expand = "none",
		},
		layout = wibox.layout.stack,
	})

	local app_name = wibox.widget({
		font = helpers.ui.set_font("Bold 12"),
		text = n.app_name:gsub("^%l", string.upper),
		widget = wibox.widget.textbox,
	})

	local dismiss = wibox.widget({
		{
			font = helpers.ui.set_font("Bold 10"),
			markup = helpers.ui.colorize_text("", theme.color.accent),
			widget = wibox.widget.textbox,
			valign = "center",
			halign = "center",
		},
		margins = dpi(4),
		widget = wibox.container.margin,
	})

	dismiss:buttons(gears.table.join(awful.button({}, 1, function()
		n:destroy(naughty.notification_closed_reason.dismissed_by_user)
	end)))

	local timeout_arc = wibox.widget({
		widget = wibox.container.arcchart,
		forced_width = dpi(26),
		forced_height = dpi(26),
		max_value = 100,
		min_value = 0,
		value = 0,
		thickness = dpi(4),
		rounded_edge = true,
		bg = theme.color.base,
		colors = {
			{
				type = "linear",
				from = { 0, 0 },
				to = { 400, 400 },
				stops = {
					{ 0, accent_colors },
					{ 0.2, accent_colors },
					{ 0.4, accent_colors },
					{ 0.6, accent_colors },
					{ 0.8, accent_colors },
				},
			},
		},
		dismiss,
	})

	local title2 = wibox.widget.textbox()
	title2.font = helpers.ui.set_font("Bold 11")
	title2.text = n.title

	local title = wibox.widget({
		widget = wibox.container.scroll.horizontal,
		step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
		fps = 60,
		speed = 75,
		title2,
	})

	local message2 = wibox.widget.textbox()
	message2.font = helpers.ui.set_font("11")
	message2.text = n.message

	local message = wibox.widget({
		widget = wibox.container.scroll.horizontal,
		step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
		fps = 60,
		speed = 75,
		message2,
	})

	local actions = wibox.widget({
		notification = n,

		base_layout = wibox.widget({
			spacing = dpi(3),
			layout = wibox.layout.flex.horizontal,
		}),

		widget_template = {
			{
				{
					{
						id = "text_role",
						font = helpers.ui.set_font("10"),
						widget = wibox.widget.textbox,
					},
					left = dpi(6),
					right = dpi(6),
					widget = wibox.container.margin,
				},
				widget = wibox.container.place,
			},
			bg = theme.color.base,
			forced_height = dpi(25),
			forced_width = dpi(70),
			widget = wibox.container.background,
		},
		style = {
			underline_normal = false,
			underline_selected = true,
		},
		widget = naughty.list.actions,
	})

	local widget = naughty.layout.box({
		notification = n,
		type = "notification",
		cursor = "hand2",
		shape = helpers.ui.rrect(12),
		border_color = theme.color.surface0,
		border_width = dpi(3),
		maximum_width = dpi(350),
		maximum_height = dpi(180),
		bg = "#00000000",

		widget_template = {
			{
				layout = wibox.layout.fixed.vertical,
				{
					{
						{
							layout = wibox.layout.align.horizontal,
							app_name,
							nil,
							timeout_arc,
						},
						margins = { top = dpi(3), bottom = dpi(3), left = dpi(15), right = dpi(15) },
						widget = wibox.container.margin,
					},
					bg = theme.color.surface0,
					widget = wibox.container.background,
				},
				{
					{
						layout = wibox.layout.fixed.vertical,
						{
							layout = wibox.layout.fixed.horizontal,
							spacing = dpi(10),
							icon,
							{
								expand = "none",
								layout = wibox.layout.align.vertical,
								nil,
								{
									layout = wibox.layout.fixed.vertical,
									title,
									message,
								},
								nil,
							},
						},
						{
							helpers.ui.vertical_pad(dpi(10)),
							{
								actions,
								shape = helpers.ui.rrect(0),
								widget = wibox.container.background,
							},
							visible = n.actions and #n.actions > 0,
							layout = wibox.layout.fixed.vertical,
						},
					},
					margins = dpi(15),
					widget = wibox.container.margin,
				},
			},
			--- Anti-aliasing container
			shape = helpers.ui.rrect(0),
			bg = theme.color.base,
			widget = wibox.container.background,
		},
	})

	--- Don't destroy the notification on click ---
	widget.buttons = {}

	--- Disables Hand Cursor in Whole wibox ---
	helpers.ui.add_hover_cursor(widget, "left_ptr")

	--- Adds Close Cursor on Close Sign ---
	helpers.ui.add_hover_cursor(dismiss, "hand2")

	local anim = animation:new({
		duration = n.timeout,
		target = 100,
		easing = animation.easing.linear,
		reset_on_stop = false,
		update = function(_, pos)
			timeout_arc.value = pos
		end,
	})

	anim:connect_signal("ended", function()
		n:reset_timeout(0.0000001)
	end)

	widget:connect_signal("mouse::enter", function()
		n:reset_timeout(0)
		anim:stop()
	end)

	widget:connect_signal("mouse::leave", function()
		anim:start()
	end)

	local notification_height = widget.height + theme.notification_spacing
	local total_notifications_height = #naughty.active * notification_height

	if total_notifications_height > n.screen.workarea.height then
		get_oldest_notification():destroy(naughty.notification_closed_reason.too_many_on_screen)
	end

	anim:start()

	--- Destroy popups notifs if dont_disturb mode is on
	---@diagnostic disable-next-line: undefined-field
	if _G.dnd_state then
		naughty.destroy_all_notifications(nil, 1)
	end
end)

require(... .. ".error")
