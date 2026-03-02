local M = {}

M.commands = {
  { target = "launcher", action = "toggle", desc = "Toggle app launcher" },
  { target = "theme", action = "toggle", desc = "Toggle theme switcher" },
  { target = "notifications", action = "dismiss_all", desc = "Dismiss all notifications" },
  { target = "notifications", action = "dnd_toggle", desc = "Toggle do-not-disturb" },
  { target = "media", action = "toggle", desc = "Toggle media popup" },
  { target = "media", action = "play_pause", desc = "Play/pause media" },
  { target = "power", action = "toggle", desc = "Toggle power menu" },
  { target = "screenshot", action = "full", desc = "Screenshot full screen" },
  { target = "screenshot", action = "region", desc = "Screenshot region" },
  { target = "wallpaper", action = "toggle", desc = "Toggle wallpaper picker" },
  { target = "settings", action = "toggle", desc = "Toggle settings panel" },
  { target = "bar", action = "toggle", desc = "Toggle bar" },
}

function M.run(target, action)
  local cmd = { "qs", "ipc", "call", target, action }
  vim.fn.jobstart(cmd, {
    on_stderr = function(_, data)
      local msg = table.concat(data, "\n")
      if msg ~= "" then
        vim.schedule(function()
          vim.notify("qs ipc error: " .. msg, vim.log.levels.ERROR)
        end)
      end
    end,
    on_exit = function(_, code)
      if code == 0 then
        vim.schedule(function()
          vim.notify(string.format("qs ipc call %s %s", target, action), vim.log.levels.INFO)
        end)
      end
    end,
  })
end

function M.telescope_picker()
  local ok, pickers = pcall(require, "telescope.pickers")
  if not ok then
    vim.notify("telescope.nvim required for IPC picker", vim.log.levels.ERROR)
    return
  end
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  pickers
    .new({}, {
      prompt_title = "Quickshell IPC",
      finder = finders.new_table({
        results = M.commands,
        entry_maker = function(entry)
          local display = string.format("%-15s %-12s  %s", entry.target, entry.action, entry.desc)
          return {
            value = entry,
            display = display,
            ordinal = entry.target .. " " .. entry.action .. " " .. entry.desc,
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          if selection then
            M.run(selection.value.target, selection.value.action)
          end
        end)
        return true
      end,
    })
    :find()
end

return M
