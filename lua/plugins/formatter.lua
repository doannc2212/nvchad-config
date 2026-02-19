local js_formatters = { "biome-check", "prettierd" }

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
      rust = { "rustfmt" },
      json = { "biome-check", "prettierd" },
      sql = { "sql_formatter" },
      html = { "biome-check", "prettierd" },
      css = { "biome-check", "prettierd" },
      -- markdown = { "prettierd" },
      markdown = {},
      graphql = { "prettierd" },
    },
    formatters = {
      ["biome-check"] = {
        require_cwd = true,
        condition = function(self, ctx)
          return vim.fs.find({ "biome.json", "biome.jsonc" }, { path = ctx.filename, upward = true })[1] ~= nil
        end,
      },
    },

    format_on_save = {
      lsp_fallback = false,
      timeout_ms = 500,
      -- only apply the first available formatter
      stop_after_first = true,
    },
  },
}
