local none_ls = require "null-ls"

local b = none_ls.builtins

local eslint_config_files = {
  ".eslintrc",
  ".eslintrc.js",
  ".eslintrc.cjs",
  ".eslintrc.json",
  ".eslintrc.yaml",
  ".eslintrc.yml",
  "eslint.config.js",
  "eslint.config.mjs",
  "eslint.config.cjs",
  "eslint.config.ts",
}

local biome_config_files = { "biome.json", "biome.jsonc" }

local oxlint_config_files = { ".oxlintrc.json", "oxlint.json" }

local sources = {

  -- Lua
  b.formatting.stylua,

  require("none-ls.formatting.eslint").with {
    condition = function(utils)
      return utils.root_has_file(eslint_config_files)
    end,
  },
  require("none-ls.diagnostics.eslint").with {
    condition = function(utils)
      return utils.root_has_file(eslint_config_files)
    end,
  },
  require("none-ls.code_actions.eslint").with {
    condition = function(utils)
      return utils.root_has_file(eslint_config_files)
    end,
  },
}

none_ls.setup {
  debug = true,
  sources = sources,
}
