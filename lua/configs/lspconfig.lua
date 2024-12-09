-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "gopls", "svelte", "jsonls", "ts_ls", "astro" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- typescript
require("typescript-tools").setup {
  on_attach = function()
    local map = vim.keymap.set
    map("n", "<M-o>", "<cmd> TSToolsOrganizeImports<CR>", { desc = "Sorts and removes unused imports" })
    map("n", "<leader>.", "<cmd> TSToolsFixAll<CR>", { desc = "Fixes all fixable errors" })
    return on_attach
  end,
  settings = {
    tsserver_plugins = {
      -- for TypeScript v4.9+
      "@styled/typescript-styled-plugin",
      -- or for older TypeScript versions
      -- "typescript-styled-plugin",
    },
  },
  on_init = on_init,
  capabilities = capabilities,
}
