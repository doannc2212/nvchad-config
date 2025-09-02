return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      javascript = { "prettierd" },
      typescript = { "prettierd" },
      tsx = { "prettierd" },
      jsx = { "prettierd" },
      typescriptreact = { "prettierd" },
      javascriptreact = { "prettierd" },
      go = { "gofmt", "gofumt" },
      rust = { "rustfmt" },
      json = { "prettierd" },
      sql = { "sqlfmt" },
      html = { "prettierd" },
      css = { "prettierd" },
      markdown = { "prettierd" },
      graphql = { "prettierd" },
    },

    format_on_save = {
      lsp_fallback = false,
      -- only apply the first available formatter
      stop_after_first = true,
    },
  },
}
