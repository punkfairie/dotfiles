local req = {
	"layout",
	"notifications",
	"scratchpad",
	"volume",
}

for _, x in pairs(req) do
	require(... .. "." .. x)
end
