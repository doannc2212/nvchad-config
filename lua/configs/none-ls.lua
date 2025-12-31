local none_ls = require "null-ls"

local b = none_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.prettierd,
  require "none-ls.formatting.eslint",

  -- Lua
  b.formatting.stylua,

  require "none-ls.diagnostics.eslint",
  require "none-ls.code_actions.eslint",
}

none_ls.setup {
  debug = true,
  sources = sources,
}
