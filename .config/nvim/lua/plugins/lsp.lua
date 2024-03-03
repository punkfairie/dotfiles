return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- general
        "commitlint",

        -- data/conf
        "yamllint",

        -- shell
        "shellcheck",
        "shfmt",
      },
    },
  },

  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      automatic_installation = true,
    },
  },

  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      --@type lspconfig.options
      servers = {
        -- data/conf
        sqlls = {},
        taplo = {},

        -- web
        html = {},
        css_variables = { mason = false },
        cssls = {},
        denols = {},
        volar = {
          filetypes = {
            "typescript",
            "javascript",
            "javascriptreact",
            "typescriptreact",
            "vue",
            "json",
          },
        },
        stylelint_lsp = {
          settings = {
            stylelintplus = {
              autoFixOnFormat = true,
              validateOnSave = true,
              validateOnType = false,
            },
          },
        },
        emmet_language_server = {
          filetypes = {
            "css",
            "eruby",
            "html",
            "javascriptreact",
            "less",
            "sass",
            "scss",
            "pug",
            "typescriptreact",
            "vue",
          },
          -- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
          -- **Note:** only the options listed in the table are supported.
          init_options = {
            ---@type table<string, string>
            includeLanguages = {},
            --- @type string[]
            excludeLanguages = {},
            --- @type string[]
            extensionsPath = {},
            --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
            preferences = {},
            --- @type boolean Defaults to `true`
            showAbbreviationSuggestions = true,
            --- @type "always" | "never" Defaults to `"always"`
            showExpandedAbbreviation = "always",
            --- @type boolean Defaults to `false`
            showSuggestionsAsSnippets = false,
            --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
            syntaxProfiles = {},
            --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
            variables = {},
          },
        },

        -- php
        intelephense = {},

        -- shell
        bashls = {},
        pkgbuild_language_server = { mason = false },
      },
    },
  },

  {
    "olrtg/nvim-emmet",
    config = function()
      vim.keymap.set({ "n", "v" }, "<leader>xe", require("nvim-emmet").wrap_with_abbreviation)
    end,
    ft = { "html", "css", "scss", "vue" },
  },

  {
    "0oAstro/dim.lua",
    event = "LspAttach",
    config = true,
  },
}
