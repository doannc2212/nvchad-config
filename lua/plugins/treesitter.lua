return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "astro",
      "bash",
      "vim",
      "lua",
      "html",
      "css",
      "javascript",
      "typescript",
      "tsx",
      "markdown",
      "markdown_inline",
      "vue",
      "go",
      "svelte",
    },
    highlight = { enable = true },
    autotag = {
      -- https://github.com/windwp/nvim-ts-autotag/issues/191#issuecomment-2161689614
      enable = false,
    },
    indent = {
      enable = true,
    },
  },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
}
