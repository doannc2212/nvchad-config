return {
  "yetone/avante.nvim",
  lazy = false,
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  version = false, -- Never set this value to "*"! Never!
  opts = {
    provider = "copilot",
    auto_suggestions_provider = "copilot",
    providers = {
      copilot = {
        model = "gpt-4.1",
      },
    },
    behaviour = {
      auto_suggestions = false, -- Experimental stage
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = false,
    },
    selector = {
      exclude_auto_select = { "NvimTree" },
    },
    file_selector = {
      provider = "telescope",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "echasnovski/mini.pick", -- for file_selector provider mini.pick
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
}
