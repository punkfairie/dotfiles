local cmp = require("cmp")

return {
  {
    "L3MON4D3/LuaSnip",
    keys = { { "<Tab>" } },
    opts = {
      store_selection_keys = "<Tab>",
    },
    config = function(_, opts)
      require("luasnip").setup(opts)

      require("luasnip.loaders.from_lua").lazy_load({ lazy_paths = { "~/.config/nvim/lua/snippets" } })
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<S-CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<C-CR>"] = function(fallback)
          cmp.abort()
          fallback()
        end,
      })

      return opts
    end,
  },

  {
    "m-pilia/vim-pkgbuild",
    ft = { "pkgbuild" },
  },
}
