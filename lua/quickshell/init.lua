local M = {}

local qs_dir = vim.fn.expand "~/.config/quickshell"

function M.is_quickshell_project()
  return vim.fn.getcwd() == qs_dir
end

function M.setup()
  -- QML filetype detection
  vim.filetype.add {
    extension = { qml = "qml" },
  }

  local ipc = require "quickshell.ipc"
  local navigate = require "quickshell.navigate"
  local templates = require "quickshell.templates"
  local theme_preview = require "quickshell.theme_preview"
  local diagnostics = require "quickshell.diagnostics"

  -- User commands (available globally, but IPC/restart only work in qs project)
  vim.api.nvim_create_user_command("Qs", function(opts)
    local args = opts.fargs
    if #args < 2 then
      vim.notify("Usage: :Qs {target} {action}", vim.log.levels.WARN)
      return
    end
    ipc.run(args[1], args[2])
  end, { nargs = "+", desc = "Run Quickshell IPC command" })

  vim.api.nvim_create_user_command("QsRestart", function()
    vim.fn.jobstart({ "pkill", "-x", "quickshell" }, {
      on_exit = function()
        vim.defer_fn(function()
          local job = vim.fn.jobstart({ "quickshell", "-p", qs_dir }, { detach = true })
          if job > 0 then
            vim.notify("Quickshell restarted", vim.log.levels.INFO)
          else
            vim.notify("Failed to start quickshell", vim.log.levels.ERROR)
          end
        end, 500)
      end,
    })
  end, { desc = "Restart Quickshell" })

  vim.api.nvim_create_user_command("QsLogs", function()
    vim.cmd "terminal journalctl --user -u quickshell -f --no-pager"
    vim.cmd "startinsert"
  end, { desc = "Show Quickshell logs" })

  vim.api.nvim_create_user_command("QsNew", function(opts)
    local args = opts.fargs
    if #args < 2 then
      vim.notify("Usage: :QsNew {module|widget|singleton} {name}", vim.log.levels.WARN)
      return
    end
    templates.create(args[1], args[2])
  end, { nargs = "+", desc = "Generate Quickshell boilerplate" })

  -- Keymaps (only in quickshell project)
  if M.is_quickshell_project() then
    local map = vim.keymap.set
    map("n", "<leader>ti", ipc.telescope_picker, { desc = "Quickshell IPC picker" })
    map("n", "<leader>tm", navigate.telescope_picker, { desc = "Quickshell module picker" })
    map("n", "<leader>tr", "<cmd>QsRestart<cr>", { desc = "Quickshell restart" })
    map("n", "<leader>tl", "<cmd>QsLogs<cr>", { desc = "Quickshell logs" })
    map("n", "<leader>tn", function()
      vim.ui.input({ prompt = "QsNew (module|widget|singleton) name: " }, function(input)
        if input and input ~= "" then
          local parts = vim.split(input, "%s+")
          if #parts >= 2 then
            templates.create(parts[1], parts[2])
          else
            vim.notify("Usage: {module|widget|singleton} {name}", vim.log.levels.WARN)
          end
        end
      end)
    end, { desc = "Quickshell new template" })
  end

  -- Diagnostics autocommands for .qml files
  diagnostics.setup()
end

return M
