local overrides = require "overrides"

local plugins = {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
  },

  {
    "NvChad/nvim-colorizer.lua",
    enabled = true,
  },

  {
    "folke/todo-comments.nvim",
    lazy = false,
    config = true,
  },

  {
    "pmizio/typescript-tools.nvim",
  },

  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    config = function()
      require("flutter-tools").setup(overrides.flutter)
    end,
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    config = true,
  },

  {
    "zbirenbaum/copilot.lua",
    -- Lazy load when event occurs. Events are triggered
    -- as mentioned in:
    -- https://vi.stackexchange.com/a/4495/20389
    event = "InsertEnter",
    -- You can also have it load at immediately at
    -- startup by commenting above and uncommenting below:
    lazy = false,
    opts = overrides.copilot,
  },

  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    config = function()
      require("spectre").setup(overrides.spectre)
    end,
  },
}

return plugins
