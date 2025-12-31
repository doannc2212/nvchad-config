local map = vim.keymap.set

map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "General Clear highlights" })

map("n", "<C-s>", "<cmd>w<CR>", { desc = "General Save file" })

map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "Toggle nvcheatsheet" })

map("n", "<leader>fm", function()
  require("conform").format { async = true }
end, { desc = "General Format file" })

-- tabufline
map("n", "<leader>bn", "<cmd>enew<CR>", { desc = "buffer new" })

map("n", "<tab>", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "<S-tab>", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

map("n", "<leader>x", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" })

map("n", "<leader>xa", function()
  require("nvchad.tabufline").closeBufs_at_direction "left"
  require("nvchad.tabufline").closeBufs_at_direction "right"
end, { desc = "buffer close all" })

-- Comment
map("n", "<leader>/", "gcc", { desc = "Toggle Comment", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })

-- nvimtree
map("n", "<leader>n", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

-- telescope
map("n", "<leader><space>", "<cmd>Telescope find_files <CR>", { desc = "Find files" })
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map("n", "<leader>th", "<cmd>Telescope themes<CR>", { desc = "telescope nvchad themes" })
map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "telescope find all files" }
)

-- terminal
map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })
map({ "n", "t" }, "<A-v>", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "terminal toggleable vertical term" })

map({ "n", "t" }, "<A-h>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal new horizontal term" })

map({ "n", "t" }, "<A-i>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "terminal toggle floating term" })

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
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })

-- replacement
map("n", "<leader>fr", function()
  require("spectre").open()
end, { desc = "Find and replace (Spectre)" })

map("n", "<leader>m", ":%s///g<Left><Left>", { desc = "Replace text on cursor" })
map("n", "<leader>mc", ":%s///gc<Left><Left><Left>", { desc = "Replace text on cursor with choice" })

map("n", "<leader>mi", function()
  require("nvchad.mason").install_all()
end, { desc = "Mason Install All" })

map("n", "<leader>cn", "<cmd>NullLsInfo<cr>", { desc = "NullLs Info" })

map("n", "<A-j>", ":m .+1<CR>==") -- move line up(n)
map("n", "<A-k>", ":m .-2<CR>==") -- move line down(n)

-- DAP (Debugger)
map("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "DAP Toggle Breakpoint" })

map("n", "<leader>dB", function()
  require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
end, { desc = "DAP Conditional Breakpoint" })

map("n", "<leader>dc", function()
  require("dap").continue()
end, { desc = "DAP Continue" })

map("n", "<leader>dC", function()
  require("dap").run_to_cursor()
end, { desc = "DAP Run to Cursor" })

map("n", "<leader>dg", function()
  require("dap").goto_()
end, { desc = "DAP Go to Line (No Execute)" })

map("n", "<leader>di", function()
  require("dap").step_into()
end, { desc = "DAP Step Into" })

map("n", "<leader>dj", function()
  require("dap").down()
end, { desc = "DAP Down" })

map("n", "<leader>dk", function()
  require("dap").up()
end, { desc = "DAP Up" })

map("n", "<leader>dl", function()
  require("dap").run_last()
end, { desc = "DAP Run Last" })

map("n", "<leader>do", function()
  require("dap").step_out()
end, { desc = "DAP Step Out" })

map("n", "<leader>dO", function()
  require("dap").step_over()
end, { desc = "DAP Step Over" })

map("n", "<leader>dp", function()
  require("dap").pause()
end, { desc = "DAP Pause" })

map("n", "<leader>dr", function()
  require("dap").repl.toggle()
end, { desc = "DAP Toggle REPL" })

map("n", "<leader>ds", function()
  require("dap").session()
end, { desc = "DAP Session" })

map("n", "<leader>dt", function()
  require("dap").terminate()
end, { desc = "DAP Terminate" })

map("n", "<leader>dw", function()
  require("dap.ui.widgets").hover()
end, { desc = "DAP Widgets" })

map("n", "<leader>du", function()
  require("dapui").toggle()
end, { desc = "DAP Toggle UI" })

map("n", "<leader>de", function()
  require("dapui").eval()
end, { desc = "DAP Eval" })

map("v", "<leader>de", function()
  require("dapui").eval()
end, { desc = "DAP Eval Selection" })

map("n", "<F5>", function()
  require("dap").continue()
end, { desc = "DAP Continue" })

map("n", "<F10>", function()
  require("dap").step_over()
end, { desc = "DAP Step Over" })

map("n", "<F11>", function()
  require("dap").step_into()
end, { desc = "DAP Step Into" })

map("n", "<F12>", function()
  require("dap").step_out()
end, { desc = "DAP Step Out" })
