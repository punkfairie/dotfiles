return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        -- data/conf
        yaml = { "yamllint" },

        -- shell
        bash = { "shellcheck" },
        sh = { "shellcheck" },
      },
    },
  },
}
