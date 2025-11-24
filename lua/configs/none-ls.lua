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
      "eslint.config.js",
      "eslint.config.mjs",
      "eslint.config.cjs",
    }
  end,
}

local prettier_config = {
  condition = function(utils)
    return utils.root_has_file {
      ".prettierrc",
      ".prettierrc.json",
      ".prettierrc.yml",
      ".prettierrc.yaml",
      ".prettierrc.json5",
      ".prettierrc.js",
      ".prettierrc.cjs",
      ".prettierrc.mjs",
      "prettier.config.js",
      "prettier.config.cjs",
      "prettier.config.mjs",
      ".prettierrc.toml",
    }
  end,
}

local b = none_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.prettierd.with(prettier_config),
  require("none-ls.formatting.eslint_d").with(eslint_config),
  -- none_ls.builtins.diagnostics.biome.with {
  --   condition = function(utils)
  --     return utils.root_has_file { "biome.json", "biome.jsonc" }
  --   end,
  -- },
  -- none_ls.builtins.code_actions.biome.with {
  --   condition = function(utils)
  --     return utils.root_has_file { "biome.json", "biome.jsonc" }
  --   end,
  -- },
  -- Lua
  b.formatting.stylua,

  require("none-ls.diagnostics.eslint_d").with(eslint_config),
  require("none-ls.code_actions.eslint_d").with(eslint_config),
}

none_ls.setup {
  debug = true,
  sources = sources,
}
