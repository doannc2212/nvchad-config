return {
  "kyazdani42/nvim-tree.lua",
  opts = {

    git = { enable = true },

    view = {
      adaptive_size = true,
      side = "left",
    },

    renderer = {
      highlight_git = true,
      icons = { show = { git = true } },
    },
  }
};
