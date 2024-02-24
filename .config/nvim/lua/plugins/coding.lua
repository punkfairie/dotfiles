return {
  {
    "L3MON4D3/LuaSnip",
    config = function(_, opts)
      require("luasnip").setup(opts)

      require("luasnip.loaders.from_lua").lazy_load({ lazy_paths = { "~/.config/nvim/lua/snippets" } })
    end,
  },
}
