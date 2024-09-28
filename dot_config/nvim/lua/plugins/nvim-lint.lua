return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        yaml = { "yamllint" },
        bash = { "shellcheck" },
        scss = { "stylelint" },
        sh = { "shellcheck" },
      },
    },
  },
}
