---@type MappingsTable
local M = {}

M.general = {
  n = {
    ["<leader>fr"] = {
      function()
        require("spectre").open()
      end,
      desc = "Replace in files (Spectre)",
    },
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
    ["gd"] = {
      function()
        require("telescope.builtin").lsp_definitions { reuse_win = true }
      end,
      "Goto Definition",
    },
    ["<M-o>"] = { "<cmd> TSToolsOrganizeImports<CR>", "Sorts and removes unused imports" },
    ["<leader>."] = { "<cmd> TSToolsFixAll<CR>", "Fixes all fixable errors" },
  },
}

-- more keybinds!

return M
