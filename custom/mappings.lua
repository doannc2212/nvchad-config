---@type MappingsTable
local M = {}

M.general = {
  n = {
    ["<leader>n"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
    ["<leader><space>"] = { "<cmd> Telescope find_files <CR>", "Find files" },
    ["<leader>,"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Toggle workspace diagnostics" },
    ["[d"] = {
      function()
        require("trouble").next { skip_groups = true, jump = true }
      end,
      "Goto prev",
    },

    ["]d"] = {
      function()
        require("trouble").previous { skip_groups = true, jump = true }
      end,
      "Goto next",
    },
  },
}

-- more keybinds!

return M
