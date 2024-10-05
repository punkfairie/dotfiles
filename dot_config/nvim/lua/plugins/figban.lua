return {
  {
    "thazelart/figban.nvim",
    lazy = true,
    cmd = "Figban",
    init = function()
      vim.g.figban_fontstyle = "ANSI Shadow"
    end,
  },
}
