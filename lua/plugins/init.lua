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
          "davidmh/cspell.nvim",
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

  { "williamboman/mason.nvim" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
  },
  {
    "windwp/nvim-ts-autotag",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
    lazy = true,
    event = "VeryLazy",
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
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    config = function()
      require("spectre").setup(overrides.spectre)
    end,
  },

  -- overrides nvchad config
  {
    "kyazdani42/nvim-tree.lua",
    opts = overrides.nvimtree,
  },
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    lazy = "leetcode" ~= vim.fn.argv(0, -1),
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim", -- required by telescope
      "MunifTanjim/nui.nvim",

      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Leet",
    opts = overrides.leetcode,
  },
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    lazy = false,
    opts = overrides.copilot,
  },

  {
    "yetone/avante.nvim",
    lazy = false,
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    version = false, -- Never set this value to "*"! Never!
    opts = overrides.avante,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
    },
    keys = {
      {
        "<leader>a+",
        function()
          local tree_ext = require "avante.extensions.nvim_tree"
          tree_ext.add_file()
        end,
        desc = "Select file in NvimTree",
        ft = "NvimTree",
      },
      {
        "<leader>a-",
        function()
          local tree_ext = require "avante.extensions.nvim_tree"
          tree_ext.remove_file()
        end,
        desc = "Deselect file in NvimTree",
        ft = "NvimTree",
      },
    },
  },
}

return plugins
