-- Priority: prettierd > oxfmt > biome-check
-- stop_after_first = true means the first formatter whose condition passes wins.
local prettier_config_files = {
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
}
local biome_config_files = { "biome.json", "biome.jsonc" }
local oxfmt_config_files = { ".oxfmtrc.json", ".oxfmtrc.jsonc", "oxfmt.config.ts" }

local function has_root_file(ctx, files)
  return vim.fs.find(files, { path = ctx.filename, upward = true })[1] ~= nil
end

local js_formatters = { "prettierd", "oxfmt", "biome-check" }

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
      json = { "prettierd", "oxfmt", "biome-check" },
      sql = { "sql_formatter" },
      html = { "prettierd", "oxfmt", "biome-check" },
      css = { "prettierd", "oxfmt", "biome-check" },
      -- markdown = { "prettierd" },
      markdown = {},
      graphql = { "prettierd", "oxfmt", "biome-check" },
      svelte = { "prettierd", "oxfmt", "biome-check" },
      vue = { "prettierd", "oxfmt", "biome-check" },
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
          return has_root_file(ctx, prettier_config_files)
        end,
      },
      oxfmt = {
        condition = function(self, ctx)
          return not has_root_file(ctx, prettier_config_files)
            and has_root_file(ctx, oxfmt_config_files)
        end,
      },
      ["biome-check"] = {
        require_cwd = true,
        condition = function(self, ctx)
          return not has_root_file(ctx, prettier_config_files)
            and not has_root_file(ctx, oxfmt_config_files)
            and has_root_file(ctx, biome_config_files)
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
