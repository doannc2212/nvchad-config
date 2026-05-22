-- Priority: prettierd > biome-check
-- stop_after_first = true means the first formatter whose condition passes wins.
local js_formatters = { "prettierd", "biome-check" }

return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      javascript = js_formatters,
      typescript = js_formatters,
      tsx = js_formatters,
      jsx = js_formatters,
      typescriptreact = js_formatters,
      javascriptreact = js_formatters,
      go = { "gofmt", "gofumt" },
      rust = { "cargo_fmt" },
      json = { "prettierd", "biome-check" },
      sql = { "sql_formatter" },
      html = { "prettierd", "biome-check" },
      css = { "prettierd", "biome-check" },
      -- markdown = { "prettierd" },
      markdown = {},
      graphql = { "prettierd", "biome-check" },
      svelte = { "prettierd", "biome-check" },
      vue = { "prettierd", "biome-check" },
    },
    formatters = {
      cargo_fmt = {
        command = "cargo",
        args = { "fmt", "--all", "--" },
        stdin = false,
        cwd = require("conform.util").root_file { "Cargo.toml" },
      },
      prettierd = {
        condition = function(self, ctx)
          return vim.fs.find({
            ".prettierrc",
            ".prettierrc.js",
            ".prettierrc.cjs",
            ".prettierrc.mjs",
            ".prettierrc.json",
            ".prettierrc.json5",
            ".prettierrc.yaml",
            ".prettierrc.yml",
            ".prettierrc.toml",
            "prettier.config.js",
            "prettier.config.cjs",
            "prettier.config.mjs",
          }, { path = ctx.filename, upward = true })[1] ~= nil
        end,
      },
      ["biome-check"] = {
        require_cwd = true,
        condition = function(self, ctx)
          -- Only run biome when no prettier config is present (prettier has higher priority)
          local has_prettier = vim.fs.find({
            ".prettierrc", ".prettierrc.js", ".prettierrc.cjs", ".prettierrc.mjs",
            ".prettierrc.json", ".prettierrc.json5", ".prettierrc.yaml", ".prettierrc.yml",
            ".prettierrc.toml", "prettier.config.js", "prettier.config.cjs", "prettier.config.mjs",
          }, { path = ctx.filename, upward = true })[1] ~= nil
          if has_prettier then return false end
          return vim.fs.find({ "biome.json", "biome.jsonc" }, { path = ctx.filename, upward = true })[1] ~= nil
        end,
      },
    },

    format_on_save = {
      lsp_fallback = false,
      timeout_ms = 3000,
      -- only apply the first available formatter
      stop_after_first = true,
    },
  },
}
