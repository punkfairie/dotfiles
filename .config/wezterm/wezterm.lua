-- wezterm API
local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Macchiato"
config.enable_tab_bar = false

config.default_prog = { "/usr/bin/fish", "-c tmux attach -t main || tmux new -s main" }

config.font = wezterm.font({
	family = "FiraCode Nerd Font",
	harfbuzz_features = {
		"cv02",
		"cv06",
		"ss01",
		"cv14",
		"onum",
		"ss04",
		"cv18",
		"cv31",
		"cv30",
		"cv25",
		"cv26",
		"cv32",
		"ss06",
		"ss07",
	},
})
config.font_size = 11.0

return config
