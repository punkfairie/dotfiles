local awful = require("awful")
local wibox = require("wibox")
local gshape = require("gears.shape")
local gmatrix = require("gears.matrix")
local beautiful = require("beautiful")

local capi = { mouse = mouse }
local theme = beautiful.get()

local ui = {}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

---Set text color
---@param text string
---@param color string
---@return string
function ui.colorize_text(text, color)
	return "<span foreground='" .. color .. "'>" .. text .. "</span>"
end

---Change a font attribute
---@param attr string attribute(s) to add, e.g. "Bold 16"
---@param font? string base font to use, for use in the theme file itself
---@return string
function ui.set_font(attr, font)
	font = font or theme.font

	return beautiful.get_merged_font(font, attr):to_string()
end

---Create an icon widget
---@param i string the icon
---@param c string the icon's color
---@return table widget the widget
function ui.create_icon(i, c)
	local widget = {
		{
			font = ui.set_font("12.5"),
			text = " " .. i,
			widget = wibox.widget.textbox,
		},
		fg = c,
		widget = wibox.container.background,
	}
	return widget
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

---Change cursor on hovering
---@param w any widget to change cursor on
---@param hover_cursor string cursor to change to
function ui.add_hover_cursor(w, hover_cursor)
	local original_cursor = "left_ptr"

	w:connect_signal("mouse::enter", function()
		local widget = capi.mouse.current_wibox
		if widget then
			widget.cursor = hover_cursor
		end
	end)

	w:connect_signal("mouse::leave", function()
		local widget = capi.mouse.current_wibox
		if widget then
			widget.cursor = original_cursor
		end
	end)
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function ui.vertical_pad(height)
	return wibox.widget({
		forced_height = height,
		layout = wibox.layout.fixed.vertical,
	})
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function ui.horizontal_pad(width)
	return wibox.widget({
		forced_width = width,
		layout = wibox.layout.fixed.horizontal,
	})
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function ui.rrect(radius)
	return function(cr, width, height)
		gshape.rounded_rect(cr, width, height, radius)
	end
end

function ui.pie(width, height, start_angle, end_angle, radius)
	return function(cr)
		gshape.pie(cr, width, height, start_angle, end_angle, radius)
	end
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function ui.prgram(height, base)
	return function(cr, width)
		gshape.parallelogram(cr, width, height, base)
	end
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function ui.prrect(radius, tl, tr, br, bl)
	return function(cr, width, height)
		gshape.partially_rounded_rect(cr, width, height, tl, tr, br, bl, radius)
	end
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function ui.custom_shape(cr, width, height)
	cr:move_to(0, height / 25)
	cr:line_to(height / 25, 0)
	cr:line_to(width, 0)
	cr:line_to(width, height - height / 25)
	cr:line_to(width - height / 25, height)
	cr:line_to(0, height)
	cr:close_path()
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local function _get_widget_geometry(_hierarchy, widget)
	local width, height = _hierarchy:get_size()
	if _hierarchy:get_widget() == widget then
		-- Get the extents of this widget in the device space
		local x, y, w, h = gmatrix.transform_rectangle(_hierarchy:get_matrix_to_device(), 0, 0, width, height)
		return { x = x, y = y, width = w, height = h, hierarchy = _hierarchy }
	end

	for _, child in ipairs(_hierarchy:get_children()) do
		local ret = _get_widget_geometry(child, widget)
		if ret then
			return ret
		end
	end
end

function ui.get_widget_geometry(_wibox, widget)
	return _get_widget_geometry(_wibox._drawable._widget_hierarchy, widget)
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function ui.screen_mask(s, bg)
	local mask = wibox({
		visible = false,
		ontop = true,
		type = "splash",
		screen = s,
	})
	awful.placement.maximize(mask)
	mask.bg = bg
	return mask
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function ui.grouping_widget(w1, w2, dpi1)
	local container = wibox.widget({
		w1,
		{
			nil,
			w2,
			expand = "none",
			layout = wibox.layout.flex.vertical,
		},
		spacing = dpi1,
		layout = wibox.layout.fixed.horizontal,
	})

	return container
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return ui
