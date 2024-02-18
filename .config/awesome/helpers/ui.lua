local gshape = require("gears.shape")

local _ui = {}

function _ui.rrect(radius)
	return function(cr, width, height)
		gshape.rounded_rect(cr, width, height, radius)
	end
end

return _ui
