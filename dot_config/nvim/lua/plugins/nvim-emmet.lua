return {
  {
    "olrtg/nvim-emmet",
    config = function()
      vim.keymap.set(
        { "n", "v" },
        "<leader>xe",
        require("nvim-emmet").wrap_with_abbreviation,
        { desc = "Wrap with Emmet abbreviation" }
      )
    end,
    ft = { "html", "css", "scss", "vue" },
  },
}
