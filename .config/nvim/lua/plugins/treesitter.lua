return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- general
        "comment",

        -- git
        "diff",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",

        -- data/conf
        "ini",
        "ssh_config",
        "toml",

        -- web
        "html",
        "css",
        "scss",
        "javascript",
        "jsdoc",
        "vue",

        -- php
        "php",
        "phpdoc",

        -- shell
        "bash",
        "fish",
      },
    },
  },
}
