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
      typescriptreact = { "biome-check", "prettierd" },
      javascriptreact = { "biome-check", "prettierd" },
      go = { "gofmt", "gofumt" },
      rust = { "rustfmt" },
      json = { "biome-check", "prettierd" },
      sql = { "sqlfmt" },
      html = { "biome-check", "prettierd" },
      css = { "biome-check", "prettierd" },
      markdown = { "prettierd" },
      graphql = { "biome-check", "prettierd" },
    },

    format_on_save = {
      lsp_fallback = false,
      -- only apply the first available formatter
      stop_after_first = true,
    },
  },
}
