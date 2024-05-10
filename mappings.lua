require "nvchad.mappings"

local map = vim.keymap.set

map("n", "<leader>fr", function() require("spectre").open() end, { desc = "Replace in files (Spectre)" })
map("n", "<leader>n", "<cmd> NvimTreeToggle <CR>", { desc = "Toggle nvimtree" })
map("n", "<leader><space>", "<cmd> Telescope find_files <CR>", { desc = "Find files" })
map("n", "<leader>,", "<cmd>TroubleToggle workspace_diagnostics<cr>", { desc = "Toggle workspace diagnostics" })
map(
  "n",
  "gd",
  function() require("telescope.builtin").lsp_definitions { reuse_win = true } end,
  { desc = "Goto Definition" }
)
map("n", "<M-o>", "<cmd> TSToolsOrganizeImports<CR>", { desc = "Sorts and removes unused imports" })
map("n", "<leader>.", "<cmd> TSToolsFixAll<CR>", { desc = "Fixes all fixable errors" })
-- map("n", "", "", { desc = "" })
