local M = {}

M.fill = function(_, _, args)
  local chars = {}

  for str in string.gmatch(args, "([^%%]+)") do
    table.insert(chars, str)
  end

  local snip = chars[1]

  local _, c = unpack(vim.api.nvim_win_get_cursor(0))

  while #snip < (vim.bo.tw - c - 1) do
    snip = snip .. chars[2]
  end

  return snip
end

return M
