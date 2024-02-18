local beautiful = require("beautiful")
local awful = require("awful")
local wibox = require("wibox")
local bling = require("lib.bling")

local keys = require("config").keys

local dpi = beautiful.xresources.apply_dpi

awful.screen.connect_for_each_screen(function(s)
	s.taglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		widget_template = {
			{
				{
					{
						id = "text_role",
						widget = wibox.widget.textbox,
					},
					layout = wibox.layout.fixed.horizontal,
				},
				left = 4,
				right = 4,
				widget = wibox.container.margin,
			},
			id = "background_role",
			widget = wibox.container.background,

			-- Hover colors & an index label.
			create_callback = function(self, c3, index)
				self:get_children_by_id("text_role")[1].markup = "<b> " .. index .. " </b>"
				self:connect_signal("mouse::enter", function()
					-- BLING: Only show widget when there are clients in the tag.
					if #c3:clients() > 0 then
						-- BLING: Update the widget with the new tag.
						awesome.emit_signal("bling::tag_preview::update", c3)
						-- BLING: Show the widget.
						awesome.emit_signal("bling::tag_preview::visibility", s, true)
					end
				end)

				self:connect_signal("mouse::leave", function()
					-- BLING: Turn the widget off.
					awesome.emit_signal("bling::tag_preview::visibility", s, false)

					if self.has_backup then
						self.bg = self.backup
					end
				end)
			end,

			update_callback = function(self, _, index)
				self:get_children_by_id("text_role")[1].markup = "<b> " .. index .. " </b>"
			end,
		},

		buttons = {
			awful.button({}, 1, function(t)
				t:view_only()
			end),

			awful.button({ keys.mod }, 1, function(t)
				if client.focus then
					client.focus:move_to_tag(t)
				end
			end),

			awful.button({}, 3, awful.tag.viewtoggle),

			awful.button({ keys.mod }, 3, function(t)
				if client.focus then
					client.focus:toggle_tag(t)
				end
			end),

			awful.button({}, 4, function(t)
				awful.tag.viewprev(t.screen)
			end),

			awful.button({}, 5, function(t)
				awful.tag.viewnext(t.screen)
			end),
		},
	})

	bling.widget.tag_preview.enable({
		show_client_content = true,
		x = 0, -- x-coord of popup
		y = 0, -- y-coord of popup
		scale = 0.2, -- scale of preview compared to screen
		honor_padding = true, -- honor padding when creating widget size
		honor_workarea = true, --honor work area when creating widget size

		placement_fn = function(c) -- place widget using awful.placement
			awful.placement.top_left(c, {
				margins = {
					top = 31,
					left = 0,
				},
			})
		end,

		background_widget = wibox.widget({ -- set bg image for the widget
			image = beautiful.wallpaper,
			horizontal_fit_policy = "fit",
			vertical_fit_policy = "fit",
			widget = wibox.widget.imagebox,
		}),
	})
end)
