local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local naughty = require("naughty")
local rubato = require("lib.rubato")

local theme = beautiful.get()
local dpi = beautiful.xresources.apply_dpi

local notifs_text = wibox.widget({
	font = helpers.ui.set_font("Bold 20"),
	markup = "Notifications",
	halign = "center",
	widget = wibox.widget.textbox,
})

local notifs_clear = wibox.widget({
	markup = helpers.ui.colorize_text(" ", theme.color.red),
	font = helpers.ui.set_font("Bold 21"),
	halign = "center",
	valign = "center",
	widget = wibox.widget.textbox,
})

notifs_clear:buttons(gears.table.join(awful.button({}, 1, function()
	_G.Notif_center_reset_notifs_container()
end)))

helpers.ui.add_hover_cursor(notifs_clear, "hand2")

local notifs_empty = wibox.widget({
	{
		nil,
		{
			nil,
			{
				markup = helpers.ui.colorize_text("Nothing Here!", theme.color.subtext1),
				font = helpers.ui.set_font("Bold 17"),
				halign = "center",
				valign = "center",
				widget = wibox.widget.textbox,
			},
			layout = wibox.layout.align.vertical,
		},
		layout = wibox.layout.align.horizontal,
	},
	forced_height = dpi(730),
	widget = wibox.container.background,
	bg = theme.color.surface0,
	shape = helpers.ui.rrect(8),
})

local notifs_container = wibox.widget({
	spacing = dpi(10),
	spacing_widget = {
		{
			shape = helpers.ui.rrect(8),
			widget = wibox.container.background,
		},
		top = dpi(2),
		bottom = dpi(2),
		left = dpi(6),
		right = dpi(6),
		widget = wibox.container.margin,
	},
	forced_width = dpi(320),
	forced_height = dpi(730), --Use it like in notifs_empty else it will look weird
	layout = wibox.layout.fixed.vertical,
})

local remove_notifs_empty = true

Notif_center_reset_notifs_container = function()
	notifs_container:reset(notifs_container)
	notifs_container:insert(1, notifs_empty)
	remove_notifs_empty = true
end

Notif_center_remove_notif = function(box)
	notifs_container:remove_widgets(box)

	if #notifs_container.children == 0 then
		notifs_container:insert(1, notifs_empty)
		remove_notifs_empty = true
	end
end

local create_notif = function(icon, n)
	local time = os.date("%H:%M")
	local box = {}

	box = wibox.widget({
		{
			{
				{
					{
						image = icon,
						resize = true,
						clip_shape = helpers.ui.rrect(8),
						halign = "center",
						valign = "center",
						widget = wibox.widget.imagebox,
					},
					strategy = "exact",
					height = dpi(50),
					width = dpi(50),
					widget = wibox.container.constraint,
				},
				{
					{
						nil,
						{
							{
								{
									step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
									speed = dpi(50),
									{
										markup = n.title,
										font = helpers.ui.set_font("Bold 9"),
										halign = "left",
										widget = wibox.widget.textbox,
									},
									forced_width = dpi(140),
									widget = wibox.container.scroll.horizontal,
								},
								nil,
								{
									markup = helpers.ui.colorize_text(time, theme.color.subtext1),
									halign = "right",
									valign = "bottom",
									font = helpers.ui.set_font("Bold 10"),
									widget = wibox.widget.textbox,
								},
								expand = "none",
								layout = wibox.layout.align.horizontal,
							},
							{
								step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
								speed = dpi(50),
								{
									markup = n.message,
									halign = "left",
									widget = wibox.widget.textbox,
								},
								forced_width = dpi(165),
								widget = wibox.container.scroll.horizontal,
							},
							spacing = dpi(3),
							layout = wibox.layout.fixed.vertical,
						},
						expand = "none",
						layout = wibox.layout.align.vertical,
					},
					left = dpi(17),
					widget = wibox.container.margin,
				},
				layout = wibox.layout.align.horizontal,
			},
			margins = dpi(15),
			widget = wibox.container.margin,
		},
		forced_height = dpi(85),
		widget = wibox.container.background,
		bg = theme.color.surface0,
		shape = helpers.ui.rrect(8),
	})

	box:buttons(gears.table.join(awful.button({}, 1, function()
		_G.Notif_center_remove_notif(box)
	end)))

	return box
end

notifs_container:buttons(gears.table.join(
	awful.button({}, 4, nil, function()
		if #notifs_container.children == 1 then
			return
		end
		notifs_container:insert(1, notifs_container.children[#notifs_container.children])
		notifs_container:remove(#notifs_container.children)
	end),

	awful.button({}, 5, nil, function()
		if #notifs_container.children == 1 then
			return
		end
		notifs_container:insert(#notifs_container.children + 1, notifs_container.children[1])
		notifs_container:remove(1)
	end)
))

notifs_container:insert(1, notifs_empty)

naughty.connect_signal("request::display", function(n)
	if #notifs_container.children == 1 and remove_notifs_empty then
		notifs_container:reset(notifs_container)
		remove_notifs_empty = false
	end

	local appicon = n.icon or n.app_icon
	if not appicon then
		appicon = theme.pfp --notification_icon
	end

	notifs_container:insert(1, create_notif(appicon, n))
end)

local notifs = wibox.widget({
	{
		{
			{
				nil,
				notifs_text,
				notifs_clear,
				expand = "none",
				layout = wibox.layout.align.horizontal,
			},
			left = dpi(5),
			right = dpi(5),
			top = dpi(7),
			bottom = dpi(7),
			layout = wibox.container.margin,
		},
		widget = wibox.container.background,
		bg = theme.color.surface0,
		shape = helpers.ui.rrect(8),
	},
	notifs_container,
	spacing = dpi(20),
	layout = wibox.layout.fixed.vertical,
})

local actions = wibox.widget({
	{
		{
			{
				widget = require("ui.notif-panel.widgets.vol_slider"),
			},
			{
				widget = require("ui.notif-panel.widgets.mic_slider"),
			},
			layout = wibox.layout.flex.vertical,
			spacing = dpi(1),
		},
		widget = wibox.container.margin,
		top = dpi(20),
		bottom = dpi(20),
		left = dpi(35),
		right = dpi(35),
	},
	forced_height = dpi(120),
	widget = wibox.container.background,
	bg = theme.color.surface0,
	shape = helpers.ui.rrect(8),
})

-- Sidebar
local action = wibox({
	visible = false,
	ontop = true,
	width = dpi(410),
	height = awful.screen.focused().geometry.height - dpi(100),
	y = dpi(60),
	bg = theme.bg_normal,
	border_width = theme.border_width * 2,
	border_color = theme.border_normal,
})

-- Sidebar widget setup
action:setup({
	{
		notifs,
		nil,
		actions,
		spacing = dpi(20),
		layout = wibox.layout.align.vertical,
	},
	margins = {
		top = dpi(20),
		bottom = dpi(20),
		left = dpi(20),
		right = dpi(20),
	},
	widget = wibox.container.margin,
})

-- Slide animation
local slide = rubato.timed({
	pos = awful.screen.focused().geometry.x - awful.screen.focused().geometry.width,
	rate = 60,
	intro = 0.2,
	duration = 0.4,
	subscribed = function(pos)
		action.x = awful.screen.focused().geometry.x - pos
	end,
})

-- Timer of action's death
action.timer = gears.timer({
	timeout = 0.5,
	single_shot = true,
	callback = function()
		action.visible = not action.visible
	end,
})
action.shape = function(cr, w, h) --Rounded Corners
	gears.shape.rounded_rect(cr, w, h, 14)
end

-- Toggle function
action.toggle = function()
	if action.visible then
		slide.target = awful.screen.focused().geometry.x - awful.screen.focused().geometry.width
		action.timer:start()
	else
		awesome.emit_signal("widget::update_vol")
		awesome.emit_signal("widget::update_mic")
		slide.target = awful.screen.focused().geometry.x
			- awful.screen.focused().geometry.width
			+ action.width
			+ dpi(25)
		action.visible = not action.visible
	end
end

-- Get signal to execute the function (if that makes sense)
awesome.connect_signal("action::toggle", function()
	action.toggle()
end)

return action
