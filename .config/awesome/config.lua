local config_dir = require("gears.filesystem").get_configuration_dir()

local M = {}

M.keys = {
	mod = "Mod4",
	alt = "Mod1",
}

M.apps = {
	terminal = "wezterm",
	launcher = "rofi -show drun -theme ~/.config/rofi/launcher.rasi",
	browser = "firefox",
	file_manager = "thunar",
	editor = os.getenv("EDITOR") or "nvim",
}

M.apps.start_editor = M.apps.terminal .. "-e" .. M.apps.editor
M.apps.music_player = M.apps.terminal .. "--class music -e ncmpcpp"

M.theme = {
	flavor = "macchiato",
	accent = "pink",
	wallpaper = config_dir .. "themes/catppuccin/buttons.png",
	icons = {},
}

M.theme.icons.tags = {
	general = " ",
	files = " ",
	media = " ",
	terminal = " ",
	coding = " ",
	misc = "󰍹 ",
}

M.widget = {}

M.widget.weather = {
	api_key = "e894c3e6c1a9d2217eee94791e845c96",
	coordinates = { lat = "47.773140", lon = "-122.303660" },
}

M.widget.github = {
	username = "punkfairie",
}

M.widget.mic = {
	name = "",
}

M.widget.disk = {
	name = "/dev/sdb3",
}

return M
