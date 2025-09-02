return {
  "neovim/nvim-lspconfig",
  event = "User FilePost",
  dependencies = {
    "pmizio/typescript-tools.nvim",
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
    -- https://github.com/NvChad/NvChad/blob/29ebe31ea6a4edf351968c76a93285e6e108ea08/lua/nvchad/configs/lspconfig.lua#L50-L72
    require("nvchad.configs.lspconfig").defaults()
    require "configs.lspconfig"
  end,
}
