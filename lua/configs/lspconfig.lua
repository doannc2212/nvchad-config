local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local servers = {
  "html",
  "cssls",
  "gopls",
  "svelte",
  "jsonls",
  "astro",
  "tailwindcss",
  "lua_ls",
  "rust-analyzer",
  "tsserver",
}

vim.lsp.enable(servers)

-- lsps with default config
for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  })
end

vim.lsp.enable(servers)

-- typescript
vim.lsp.config("vtsls", {
  on_attach = function()
    local map = vim.keymap.set
    map("n", "<M-o>", function()
      vim.lsp.buf.code_action {
        context = {
          only = { "source.organizeImports" },
          diagnostics = {},
        },
        apply = true,
      }
    end, { desc = "Typescript organize imports" })
    map("n", "<leader>ra", function()
      vim.lsp.buf.rename()
    end, { desc = "Typescript rename" })
    map("n", "<leader>.", function()
      vim.lsp.buf.code_action {
        context = {
          diagnostics = {},
          only = { "source.fixAll.ts" },
        },
        apply = true,
      }
    end, { desc = "Fix all errors" })
    map("n", "<leader>io", function()
      vim.lsp.buf.code_action {
        context = {
          only = { "source.addMissingImports" },
          diagnostics = {},
        },
        apply = true,
      }
    end, { desc = "Add missing imports" })
    return on_attach
  end,
  settings = {
    typescript = {
      inlayHints = {
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
  },
  on_init = on_init,
  capabilities = capabilities,
})

vim.lsp.enable "vtsls"
