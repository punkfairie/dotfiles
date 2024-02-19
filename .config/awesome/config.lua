local M = {}

M.keys = {
	mod = "Mod4",
	alt = "Mod1",
}

M.apps = {
	terminal = "wezterm",
	browser = "firefox",
	editor = os.getenv("EDITOR") or "nvim",
}

M.apps.start_editor = M.apps.terminal .. "-e" .. M.apps.editor

M.widget = {}

M.widget.weather = {
	api_key = "",
	coordinates = { lat = "", lon = "" },
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
