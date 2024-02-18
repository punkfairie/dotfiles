local gshape = require("gears.shape")

local capi = { mouse = mouse }

local _ui = {}

function _ui.rrect(radius)
	return function(cr, width, height)
		gshape.rounded_rect(cr, width, height, radius)
	end
end

function _ui.add_hover_cursor(w, hover_cursor)
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

return _ui
