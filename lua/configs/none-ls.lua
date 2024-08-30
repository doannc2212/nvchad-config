local none_ls = require "null-ls"
local funcs = require "funcs"

local eslint_config = {
  extra_filetypes = { "astro" },
  condition = function(utils)
    return utils.root_has_file {
      ".eslintrc",
      ".eslintrc.js",
      ".eslintrc.cjs",
      ".eslintrc.yaml",
      ".eslintrc.yml",
      ".eslintrc.json",
    }
  end,
}


local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local b = none_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.prettierd,
  require("none-ls.formatting.eslint_d").with(eslint_config),

  -- Lua
  b.formatting.stylua,

  -- b.completion.spell,
  require("none-ls.diagnostics.eslint_d").with(eslint_config),
  require("none-ls.code_actions.eslint_d").with(eslint_config),
}

none_ls.setup {
  debug = true,
  sources = sources,
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          funcs.async_formatting(bufnr)
        end,
      })
    end
  end,
}

-- golang org import on save
local autocmd = vim.api.nvim_create_autocmd
autocmd("BufWritePre", {
  pattern = "*.go",
  callback = funcs.organize_imports
})
