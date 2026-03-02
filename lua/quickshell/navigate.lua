local M = {}

local qs_dir = vim.fn.expand("~/.config/quickshell")

M.modules = {
  { name = "shell", file = "shell.qml", desc = "Entry point / assembler" },
  { name = "bar", file = "bar/Bar.qml", desc = "Status bar" },
  { name = "bar/Time", file = "bar/Time.qml", desc = "Time singleton" },
  { name = "bar/SystemInfo", file = "bar/SystemInfo.qml", desc = "SystemInfo singleton" },
  { name = "bar/DefaultTheme", file = "bar/DefaultTheme.qml", desc = "Bar fallback theme" },
  { name = "app-launcher", file = "app-launcher/AppLauncher.qml", desc = "App launcher" },
  { name = "app-launcher/DefaultTheme", file = "app-launcher/DefaultTheme.qml", desc = "Launcher fallback theme" },
  { name = "notifications", file = "notifications/NotificationPopup.qml", desc = "Notification popup" },
  { name = "notifications/Service", file = "notifications/NotificationService.qml", desc = "NotificationServer singleton" },
  { name = "notifications/DefaultTheme", file = "notifications/DefaultTheme.qml", desc = "Notifications fallback theme" },
  { name = "theme-switcher", file = "theme-switcher/ThemeSwitcher.qml", desc = "Theme picker UI" },
  { name = "theme-switcher/Theme", file = "theme-switcher/Theme.qml", desc = "Theme singleton (206 themes)" },
  { name = "theme-switcher/DefaultTheme", file = "theme-switcher/DefaultTheme.qml", desc = "Theme fallback" },
  { name = "media", file = "media/MediaControl.qml", desc = "MPRIS media controls" },
  { name = "media/DefaultTheme", file = "media/DefaultTheme.qml", desc = "Media fallback theme" },
  { name = "osd", file = "osd/OSD.qml", desc = "Volume/brightness OSD" },
  { name = "osd/DefaultTheme", file = "osd/DefaultTheme.qml", desc = "OSD fallback theme" },
  { name = "wallpaper", file = "wallpaper/WallpaperManager.qml", desc = "Wallpaper picker" },
  { name = "wallpaper/Service", file = "wallpaper/WallpaperService.qml", desc = "WallpaperService singleton" },
  { name = "wallpaper/DefaultTheme", file = "wallpaper/DefaultTheme.qml", desc = "Wallpaper fallback theme" },
}

function M.telescope_picker()
  local ok, pickers = pcall(require, "telescope.pickers")
  if not ok then
    vim.notify("telescope.nvim required for module picker", vim.log.levels.ERROR)
    return
  end
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local previewers = require("telescope.previewers")

  -- Filter to only existing files
  local entries = {}
  for _, mod in ipairs(M.modules) do
    local path = qs_dir .. "/" .. mod.file
    if vim.fn.filereadable(path) == 1 then
      table.insert(entries, mod)
    end
  end

  pickers
    .new({}, {
      prompt_title = "Quickshell Modules",
      finder = finders.new_table({
        results = entries,
        entry_maker = function(entry)
          local display = string.format("%-28s %s", entry.name, entry.desc)
          return {
            value = entry,
            display = display,
            ordinal = entry.name .. " " .. entry.desc .. " " .. entry.file,
            filename = qs_dir .. "/" .. entry.file,
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
      previewer = previewers.vim_buffer_cat.new({}),
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          if selection then
            vim.cmd("edit " .. vim.fn.fnameescape(selection.filename))
          end
        end)
        return true
      end,
    })
    :find()
end

return M
