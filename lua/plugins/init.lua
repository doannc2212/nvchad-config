return {
  require "plugins.mason",
  require "plugins.avante",
  require "plugins.nvim-lspconfig",
  require "plugins.treesitter",
  require "plugins.ts-autotag",
  require "plugins.comment",
  require "plugins.todo",
  require "plugins.trouble",
  require "plugins.spectre",
  require "plugins.nvimtree",
  require "plugins.copilot",
  require "plugins.leetcode",
  require "plugins.formatter",
  require "plugins.dadbod",
  require "plugins.dap",
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        tailwind = true,
      },
    },
  },
  {
    "esmuellert/vscode-diff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = "CodeDiff",
  },
}
