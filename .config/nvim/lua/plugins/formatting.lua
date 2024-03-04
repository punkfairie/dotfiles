return {
  {
    "stevearc/conform.nvim",

    -- @class ConformOpts
    opts = {
      formatters_by_ft = {
        -- lua
        lua = { "stylua" },

        -- data/conf
        sql = { "prettier" },
        json = { "prettier" },
        toml = { "prettier" },
        yaml = { "prettier" },

        -- web
        html = { "prettier" },
        liquid = { "prettier" },
        css = { "stylelint", "prettier" },
        scss = { "stylelint", "prettier" },
        javascript = { "eslint", "prettier" },
        typescript = { "eslint", "prettier" },
        vue = { "eslint", "prettier" },
        markdown = { "prettier" },

        -- php
        php = { "pint" },

        -- shell
        sh = { "shellcheck", "shfmt" },
        fish = { "fish_indent" },

        -- misc
        ruby = { "prettier" },
      },
      formatters = {
        shfmt = {
          prepend_args = { "--indent=2", "--case-indent", "--binary-next-line", "--func-next-line" },
        },
      },
    },
  },
}
