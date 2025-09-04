local none_ls = require "null-ls"

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

local b = none_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.prettierd,
  require("none-ls.formatting.eslint_d").with(eslint_config),

  -- Lua
  b.formatting.stylua,

  require("none-ls.diagnostics.eslint_d").with(eslint_config),
  require("none-ls.code_actions.eslint_d").with(eslint_config),
}

none_ls.setup {
  debug = true,
  sources = sources,
}
