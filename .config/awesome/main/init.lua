local req = {
	"error_handling",
	"layout",
	"menu",
	"wallpaper",
	"bindings",
	"custom_bindings",
	"rules",
	"tags",
}

for _, x in pairs(req) do
	require(... .. "." .. x)
end
