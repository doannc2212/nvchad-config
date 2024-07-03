local overrides = require "overrides"

local plugins = {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "pmizio/typescript-tools.nvim",
      -- format & linting
      {
        "nvimtools/none-ls.nvim",
        dependencies = {
          "nvimtools/none-ls-extras.nvim",
        },
        config = function()
          require "configs.none-ls"
        end,
      },
    },
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
      "windwp/nvim-ts-autotag",
    },
  },

  {
    "numToStr/Comment.nvim",
    config = function(_)
      require("Comment").setup {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end,
    lazy = false,
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

  -- overrides nvchad config
  {
    "kyazdani42/nvim-tree.lua",
    opts = {
      view = { adaptive_size = true },
    },
  },
}

return plugins
