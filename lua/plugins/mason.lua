-- https://github.com/NvChad/NvChad/blob/29ebe31ea6a4edf351968c76a93285e6e108ea08/lua/nvchad/configs/mason.lua#L1C1-L1C38
dofile(vim.g.base46_cache .. "mason")

return {
  "mason-org/mason.nvim",
  cmd = { "Mason", "MasonInstall", "MasonUpdate" },
  opts = {
    PATH = "skip",

    ui = {
      icons = {
        package_pending = " ",
        package_installed = " ",
        package_uninstalled = " ",
      },
    },

    max_concurrent_installers = 10,

    ensure_installed = {
      "bash-language-server",
      "gopls",
      "clangd",
      "rust-analyzer",
      "lua-language-server",

      "astro-language-server",
      "svelte-language-server",
      "css-lsp",
      "html-lsp",
      "tailwindcss-language-server",
      "typescript-language-server",
      "vtsls",

      "json-language-server",
      "yaml-language-server",

      "prettierd",
      "eslint_d",
      "stylua",

      "cspell",

      "sonarlint-language-server",
    },
  },
}
