local awful = require("awful")

local config = require("config")
local microphone = config.widget.mic.name

local vol_sc = "pamixer --source " .. microphone .. " --get-volume"
local mute_sc = "pamixer --source " .. microphone .. " --get-mute"

local function get_vol()
	awful.spawn.easy_async_with_shell(vol_sc, function(vol)
		awful.spawn.easy_async_with_shell(mute_sc, function(mute)
			local muted

			if mute:match("false") then
				muted = false
			else
				muted = true
			end

			awesome.emit_signal("signal::mic", vol, muted)
		end)
	end)
end
awesome.connect_signal("widget::update_mic", function() -- Needs to be Updated if muted! For Mute in Sidebar Widget
	get_vol()
end)
get_vol()
