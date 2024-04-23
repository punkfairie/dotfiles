return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        sql = { "sqlfluff" },
        yaml = { "yamllint" },
        bash = { "shellcheck" },
        sh = { "shellcheck" },
      },
    },
  },
}
