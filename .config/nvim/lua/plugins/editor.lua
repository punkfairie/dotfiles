return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      close_if_last_window = true,
      window = {
        width = 30,
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
        },
      },
    },
  },

  {
    "FotiadisM/tabset.nvim",
    opts = {
      defaults = {
        tabwidth = 2,
        expandtab = true,
      },
      languages = {
        fish = {
          tabwidth = 4,
        },
      },
    },
  },

  {
    "gbprod/cutlass.nvim",
    event = "BufReadPost",
    opts = {
      cut_key = "x",
      override_del = true,
      registers = {
        select = "_",
        delete = "d",
        change = "_",
      },
    },
  },

  {
    "rainbowhxch/beacon.nvim",
    event = "CursorMoved",
    cond = function()
      return not vim.g.neovide
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    dependencies = {
      {
        "sindrets/diffview.nvim",
        config = true,
      },
    },
  },

  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
  },
}
