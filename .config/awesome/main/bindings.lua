local awful = require("awful")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local machi = require("lib.layout-machi")

local apps = require("config").apps
local menu = require("ui.menu")
local keys = require("config").keys

-- General --
awful.keyboard.append_global_keybindings({
	awful.key({ keys.mod, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
	awful.key({ keys.mod, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),
	awful.key({ keys.mod, "Control" }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),

	awful.key({ keys.mod }, "q", function()
		awesome.emit_signal("module::exit_screen:show")
	end, { description = "show exit screen", group = "awesome" }),

	awful.key({ keys.mod, "Shift" }, "c", function()
		menu.mainmenu:show()
	end, { description = "show main menu", group = "awesome" }),

	awful.key({ keys.mod }, "p", function()
		menubar.show()
	end, { description = "show the menu bar", group = "launcher" }),

	awful.key({ keys.mod }, "r", function()
		awful.spawn("rofi -show drun -theme ~/.config/rofi/launcher.rasi")
	end, { description = "show rofi", group = "launcher" }),

	awful.key({ keys.mod }, "Return", function()
		awful.spawn(apps.terminal)
	end, { description = "open a terminal", group = "launcher" }),
})

-- Tags --
awful.keyboard.append_global_keybindings({
	awful.key({ keys.mod }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
	awful.key({ keys.mod }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
	awful.key({ keys.mod }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),
})

awful.keyboard.append_global_keybindings({
	awful.key({
		modifiers = { keys.mod },
		keygroup = "numrow",
		description = "only view tag",
		group = "tag",
		on_press = function(index)
			local screen = awful.screen.focused()
			local tag = screen.tags[index]
			if tag then
				tag:view_only()
			end
		end,
	}),

	awful.key({
		modifiers = { keys.mod, "Control" },
		keygroup = "numrow",
		description = "toggle tag",
		group = "tag",
		on_press = function(index)
			local screen = awful.screen.focused()
			local tag = screen.tags[index]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end,
	}),

	awful.key({
		modifiers = { keys.mod, "Shift" },
		keygroup = "numrow",
		description = "move focused client to tag",
		group = "tag",
		on_press = function(index)
			if client.focus then
				local tag = client.focus.screen.tags[index]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end,
	}),

	awful.key({
		modifiers = { keys.mod, "Control", "Shift" },
		keygroup = "numrow",
		description = "toggle focused client on tag",
		group = "tag",
		on_press = function(index)
			if client.focus then
				local tag = client.focus.screen.tags[index]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end,
	}),
})

-- Focus --
awful.keyboard.append_global_keybindings({
	awful.key({ keys.mod }, "j", function()
		awful.client.focus.byidx(1)
	end, { description = "focus next by index", group = "client" }),

	awful.key({ keys.mod }, "k", function()
		awful.client.focus.byidx(-1)
	end, { description = "focus previous by index", group = "client" }),

	awful.key({ keys.mod }, "Tab", function()
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end, { description = "go back", group = "client" }),

	awful.key({ keys.mod, "Control" }, "j", function()
		awful.screen.focus_relative(1)
	end, { description = "focus the next screen", group = "screen" }),

	awful.key({ keys.mod, "Control" }, "k", function()
		awful.screen.focus_relative(-1)
	end, { description = "focus the previous screen", group = "screen" }),

	awful.key({ keys.mod, "Control" }, "n", function()
		local c = awful.client.restore()
		if c then
			c:activate({ raise = true, context = "key.unminimize" })
		end
	end, { description = "restore minimized", group = "client" }),
})

-- Layouts --
awful.keyboard.append_global_keybindings({
	awful.key({
		modifiers = { keys.mod },
		keygroup = "numpad",
		description = "select layout directly",
		group = "layout",
		on_press = function(index)
			local t = awful.screen.focused().selected_tag
			if t then
				t.layout = t.layouts[index] or t.layout
			end
		end,
	}),

	awful.key({ keys.mod, "Shift" }, "j", function()
		awful.client.swap.byidx(1)
	end, { description = "swap with next client by index", group = "client" }),

	awful.key({ keys.mod, "Shift" }, "k", function()
		awful.client.swap.byidx(-1)
	end, { description = "swap with previous client by index", group = "client" }),

	awful.key(
		{ keys.mod },
		"u",
		awful.client.urgent.jumpto,
		{ description = "jump to urgent client", group = "client" }
	),

	awful.key({ keys.mod }, "l", function()
		awful.tag.incmwfact(0.05)
	end, { description = "increase master width factor", group = "layout" }),

	awful.key({ keys.mod }, "h", function()
		awful.tag.incmwfact(-0.05)
	end, { description = "decrease master width factor", group = "layout" }),

	awful.key({ keys.mod, "Shift" }, "h", function()
		awful.tag.incnmaster(1, nil, true)
	end, { description = "increase the number of master clients", group = "layout" }),

	awful.key({ keys.mod, "Shift" }, "l", function()
		awful.tag.incnmaster(-1, nil, true)
	end, { description = "decrease the number of master clients", group = "layout" }),

	awful.key({ keys.mod, "Control" }, "h", function()
		awful.tag.incncol(1, nil, true)
	end, { description = "increase the number of columns", group = "layout" }),

	awful.key({ keys.mod, "Control" }, "l", function()
		awful.tag.incncol(-1, nil, true)
	end, { description = "decrease the number of columns", group = "layout" }),

	awful.key({ keys.mod }, "space", function()
		awful.layout.inc(1)
	end, { description = "select next layout", group = "layout" }),

	awful.key({ keys.mod, "Shift" }, "space", function()
		awful.layout.inc(-1)
	end, { description = "select previous", group = "layout" }),

	awful.key({ keys.mod }, "-", function()
		machi.default_editor.start_interactive()
	end, { description = "edit the current layout if it is a machi layout", group = "layout" }),

	awful.key({ keys.mod }, ".", function()
		machi.switcher.start(client.focus)
	end, { description = "switch between windows for a machi layout", group = "layout" }),
})

-- Client --
client.connect_signal("request::default_keybindings", function()
	awful.keyboard.append_client_keybindings({
		awful.key({ keys.mod }, "f", function(c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end, { description = "toggle fullscreen", group = "client" }),

		awful.key({ keys.mod }, "w", function(c)
			c:kill()
		end, { description = "close", group = "client" }),

		awful.key(
			{ keys.mod, "Control" },
			"space",
			awful.client.floating.toggle,
			{ description = "toggle floating", group = "client" }
		),

		awful.key({ keys.mod, "Control" }, "Return", function(c)
			c:swap(awful.client.getmaster())
		end, { description = "move to master", group = "client" }),

		awful.key({ keys.mod }, "o", function(c)
			c:move_to_screen()
		end, { description = "move to screen", group = "client" }),

		awful.key({ keys.mod }, "t", function(c)
			c.ontop = not c.ontop
		end, { description = "toggle keep on top", group = "client" }),

		awful.key({ keys.mod }, "n", function(c)
			c.minimized = true
		end, { description = "minimized", group = "client" }),

		awful.key({ keys.mod }, "m", function(c)
			c.maximized = not c.maximized
			c:raise()
		end, { description = "(un)maximize", group = "client" }),

		awful.key({ keys.mod, "Control" }, "m", function(c)
			c.maximized_vertical = not c.maximized_vertical
			c:raise()
		end, { description = "(un)maximize vertically", group = "client" }),

		awful.key({ keys.mod, "Shift" }, "m", function(c)
			c.maximized_horizontal = not c.maximized_horizontal
			c:raise()
		end, { description = "(un)maximize horizontally", group = "client" }),
	})
end)

-- Mouse --
awful.mouse.append_global_mousebindings({
	awful.button({}, 3, function()
		menu.mainmenu:toggle()
	end),

	awful.button({}, 4, awful.tag.viewprev),
	awful.button({}, 5, awful.tag.viewnext),
})

client.connect_signal("request::default_mousebindings", function()
	awful.mouse.append_client_mousebindings({
		awful.button({}, 1, function(c)
			c:activate({ context = "mouse_click" })
		end),

		awful.button({ keys.mod }, 1, function(c)
			c:activate({ context = "mouse_click", action = "mouse_move" })
		end),

		awful.button({ keys.mod }, 3, function(c)
			c:activate({ context = "mouse_click", action = "mouse_resize" })
		end),
	})
end)
