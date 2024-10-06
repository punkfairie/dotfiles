return {
  {
    "KabbAmine/zeavim.vim",
    cmd = { "Zeavim", "ZeavimV", "Docset" },
    keys = {
      {
        "<leader>z",
        "<Plug>Zeavim",
        desc = "Search word under cursor in Zeal",
      },
      {
        "<leader>z",
        "<Plug>ZVVisSelection",
        mode = "v",
        desc = "Search visual selection in Zeal",
      },
      { "gz", "<Plug>ZVOperator", desc = "Search motion/text-object in Zeal" },
      {
        "<leader><leader>z",
        "<Plug>ZVKeyDocset",
        desc = "Search a specific docset in Zeal",
      },
    },
  },
}
