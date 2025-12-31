return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      javascript = { "biome-check", "prettierd" },
      typescript = { "biome-check", "prettierd" },
      tsx = { "biome-check", "prettierd" },
      jsx = { "biome-check", "prettierd" },
      typescriptreact = { "prettierd" },
      javascriptreact = { "prettierd" },
      go = { "gofmt", "gofumt" },
      rust = { "rustfmt" },
      json = { "prettierd" },
      sql = { "sql_formatter", "sqlfmt" },
      html = { "biome-check", "prettierd" },
      css = { "biome-check", "prettierd" },
      -- markdown = { "prettierd" },
      markdown = {},
      graphql = { "prettierd" },
    },
    formatters = {
      ["biome-check"] = {
        require_cwd = true,
      },
    },

    format_on_save = {
      lsp_fallback = false,
      imeout_ms = 500,
      -- only apply the first available formatter
      stop_after_first = true,
    },
  },
}
