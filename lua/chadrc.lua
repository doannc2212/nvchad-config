local M = {}

M.base46 = {
  theme_toggle = { "chadracula", "one_light" },
  theme = "chadracula", -- default theme
  transparency = true,
}

M.ui = {
  telescope = { style = "bordered" }, -- borderless / bordered
}

M.mason = {
  pkgs = {
    -- Formatters/Linters
    "biome",
    "prettierd",
    "eslint",
    "stylua",
    "sonarlint-language-server",

    -- Language Servers
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
  },
}

return M
