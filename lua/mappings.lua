require "nvchad.mappings"

local map = vim.keymap.set

-- Files
map("n", "<leader><space>", "<cmd> Telescope find_files <CR>", { desc = "Find files" })

-- Trouble
map("n", "<leader>,", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Toggle diagnostics" })
map(
  "n",
  "<leader>,s",
  "<cmd>Trouble symbols toggle pinned=true results.win.relative=win results.win.position=right<cr>",
  { desc = "Toggle diagnostics" }
)
-- LSP
map("n", "gd", function()
  require("telescope.builtin").lsp_definitions { reuse_win = true }
end, { desc = "Goto Definition" })
map("n", "K", vim.lsp.buf.hover, { desc = "Show hover" })

-- replacement
map("n", "<leader>fr", function()
  require("spectre").open()
end, { desc = "Replace in files (Spectre)" })
map("n", "<leader>m", ":%s///g<Left><Left>", { desc = "Replace text on cursor" })
map("n", "<leader>mc", ":%s///gc<Left><Left><Left>", { desc = "Replace text on cursor with choice" })
