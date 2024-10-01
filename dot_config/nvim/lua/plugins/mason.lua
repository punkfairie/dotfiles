return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- general
        "prettier",

        -- data/conf
        "yamllint",

        -- php
        "blade-formatter",
        "pint",
        "rustywind",

        -- web
        "emmet-language-server",

        -- shell
        "shfmt",
      },
    },
  },
}
