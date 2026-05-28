local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- ─── Project-type detection ───────────────────────────────────────────────────

--- Inspect the root directory and return one of:
---   "svelte" | "vue" | "react" | "astro" | "nestjs" | "unknown"
local function get_project_type(root)
  if not root then
    return "unknown"
  end
  -- Svelte: dedicated config file
  if vim.fn.filereadable(root .. "/svelte.config.js") == 1
    or vim.fn.filereadable(root .. "/svelte.config.ts") == 1
  then
    return "svelte"
  end
  -- Astro: dedicated config file
  if vim.fn.filereadable(root .. "/astro.config.mjs") == 1
    or vim.fn.filereadable(root .. "/astro.config.ts") == 1
    or vim.fn.filereadable(root .. "/astro.config.js") == 1
  then
    return "astro"
  end
  -- NestJS: nest-cli.json
  if vim.fn.filereadable(root .. "/nest-cli.json") == 1 then
    return "nestjs"
  end
  -- Vue / React: inspect package.json
  local pkg = root .. "/package.json"
  if vim.fn.filereadable(pkg) == 1 then
    local ok, content = pcall(table.concat, vim.fn.readfile(pkg), "\n")
    if ok then
      if content:find('"vue"') or content:find('"nuxt"') or content:find('"@nuxt/') then
        return "vue"
      end
      if content:find('"react"') or content:find('"react%-dom"') then
        return "react"
      end
    end
  end
  return "unknown"
end

--- Returns a root_dir function that resolves only when the project type is
--- one of the given allowed_types, preventing the LSP from attaching otherwise.
local function only_for(allowed_types)
  return function(fname, _)
    local root = vim.fs.root(fname, { "package.json", ".git" })
    if not root then
      return nil
    end
    local ptype = get_project_type(root)
    for _, t in ipairs(allowed_types) do
      if ptype == t then
        return root
      end
    end
    return nil
  end
end

local frontend = { "react", "vue", "svelte", "astro" }

-- ─── Language-specific servers (not framework-sensitive) ─────────────────────

local servers = { "gopls", "jsonls", "astro", "lua_ls", "rust_analyzer" }

for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  })
end
vim.lsp.enable(servers)

-- ─── Frontend-only servers (React / Vue / Svelte) ────────────────────────────

for _, lsp in ipairs { "html", "cssls" } do
  vim.lsp.config(lsp, {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    root_dir = only_for(frontend),
  })
end
vim.lsp.enable { "html", "cssls" }

vim.lsp.config("tailwindcss", {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  root_dir = only_for(frontend),
  filetypes = {
    "html", "css", "scss", "less",
    "javascript", "javascriptreact",
    "typescript", "typescriptreact",
    "svelte", "vue", "astro",
    "rust",
  },
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          -- clsx / cn / cva / cx patterns
          { "clsx\\(([^)]*)\\)",     "(?:'|\"|`)([^']*)(?:'|\"|`)" },
          { "cn\\(([^)]*)\\)",       "(?:'|\"|`)([^']*)(?:'|\"|`)" },
          { "cva\\(([^)]*)\\)",      "(?:'|\"|`)([^']*)(?:'|\"|`)" },
          { "cx\\(([^)]*)\\)",       "(?:'|\"|`)([^']*)(?:'|\"|`)" },
          { "variants\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
        },
      },
    },
  },
})
vim.lsp.enable "tailwindcss"

-- ─── Svelte ───────────────────────────────────────────────────────────────────

vim.lsp.config("svelte", {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  root_dir = only_for { "svelte" },
})
vim.lsp.enable "svelte"

-- ─── Vue (volar) ─────────────────────────────────────────────────────────────

vim.lsp.config("volar", {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  root_dir = only_for { "vue" },
})
vim.lsp.enable "volar"

-- ─── Biome ────────────────────────────────────────────────────────────────────

vim.lsp.config("biome", {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  -- Only attach when no higher-priority linter (eslint) is present
  root_dir = function(fname)
    local eslint_configs = {
      ".eslintrc", ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json",
      ".eslintrc.yaml", ".eslintrc.yml", "eslint.config.js", "eslint.config.mjs",
      "eslint.config.cjs", "eslint.config.ts",
    }
    if vim.fs.root(fname, eslint_configs) then return nil end
    return vim.fs.root(fname, { "biome.json", "biome.jsonc" })
  end,
})
vim.lsp.enable "biome"

-- ─── QML ─────────────────────────────────────────────────────────────────────

vim.lsp.config("qmlls", {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  cmd = {
    "qmlls6",
    "-I",
    "/usr/lib/qt6/qml",
    "-b",
    "/usr/lib/qt6/qml",
    "--no-cmake-calls",
  },
  filetypes = { "qml", "qmljs" },
  root_markers = { "shell.qml", ".git" },
})
vim.lsp.enable "qmlls"

-- ─── TypeScript / JavaScript (vtsls) — all JS/TS project types ───────────────

vim.lsp.config("vtsls", {
  on_attach = function(client, bufnr)
    local map = vim.keymap.set
    local opts = { buffer = bufnr }
    map("n", "<M-o>", function()
      vim.lsp.buf.code_action {
        context = { only = { "source.organizeImports" }, diagnostics = {} },
        apply = true,
      }
    end, vim.tbl_extend("force", opts, { desc = "Typescript organize imports" }))
    map("n", "<leader>ra", function()
      vim.lsp.buf.rename()
    end, vim.tbl_extend("force", opts, { desc = "Typescript rename" }))
    map("n", "<leader>.", function()
      vim.lsp.buf.code_action {
        context = { diagnostics = {}, only = { "source.fixAll.ts" } },
        apply = true,
      }
    end, vim.tbl_extend("force", opts, { desc = "Fix all errors" }))
    map("n", "<leader>io", function()
      vim.lsp.buf.code_action {
        context = { only = { "source.addMissingImports" }, diagnostics = {} },
        apply = true,
      }
    end, vim.tbl_extend("force", opts, { desc = "Add missing imports" }))
    on_attach(client, bufnr)
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
