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

  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },

  {
    "luckasRanarison/nvim-devdocs",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      ensure_installed = {
        "bash",
        "bootstrap~5",
        "css",
        "eslint",
        "fish~3.7",
        "html",
        "http",
        "javascript",
        "laravel~10",
        "liquid",
        "lodash~4",
        "lua~5.4",
        "markdown",
        "nginx",
        "node",
        "php",
        "postgresql~16",
        "sass",
        "typescript",
        "vite",
        "vue~3",
        "dom",
      },
    },
  },
}
