local req = {
	"better-resize",
	"savefloats",
	"exit-screen",
}

for _, x in pairs(req) do
	require(... .. "." .. x)
end
