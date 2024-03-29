local bling = require("lib.bling")
local rubato = require("lib.rubato")

-- These are example rubato tables. You can use one for just y, just x, or both.
-- The duration and easing is up to you. Please check out the rubato docs to learn more.
local anim_y = rubato.timed({
	pos = -1000,
	rate = 60,
	intro = 0.2,
	duration = 0.4,
	awestore_compat = true, -- This option must be set to true.
})

local term_scratch = bling.module.scratchpad({
	command = "alacritty --class spad", -- How to spawn the scratchpad
	rule = { instance = "spad" }, -- The rule that the scratchpad will be searched by
	sticky = true, -- Whether the scratchpad should be sticky
	autoclose = true, -- Whether it should hide itself when losing focus
	floating = true, -- Whether it should be floating (MUST BE TRUE FOR ANIMATIONS)
	geometry = { x = 456, y = 33, height = 600, width = 1000 }, -- The geometry in a floating state
	reapply = true, -- Whether all those properties should be reapplied on every new opening of the scratchpad (MUST BE TRUE FOR ANIMATIONS)
	dont_focus_before_close = false, -- When set to true, the scratchpad will be closed by the toggle function regardless of whether its focused or not. When set to false, the toggle function will first bring the scratchpad into focus and only close it on a second call
	rubato = { y = anim_y }, -- Optional. This is how you can pass in the rubato tables for animations. If you don't want animations, you can ignore this option.
})
awesome.connect_signal("scratchpad::toggle", function()
	term_scratch:toggle()
end)
