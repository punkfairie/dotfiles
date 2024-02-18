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

return M
