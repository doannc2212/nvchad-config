local M = {}

local qs_dir = vim.fn.expand("~/.config/quickshell")

local default_theme_template = [[import QtQuick

QtObject {
  readonly property color bgBase: "#1a1b26"
  readonly property color bgSurface: "#24283b"
  readonly property color bgOverlay: "#88000000"
  readonly property color bgHover: "#1e2235"
  readonly property color bgSelected: "#283457"
  readonly property color bgBorder: "#32364a"

  readonly property color textPrimary: "#c0caf5"
  readonly property color textSecondary: "#a9b1d6"
  readonly property color textMuted: "#565f89"

  readonly property color accentPrimary: "#7aa2f7"
  readonly property color accentCyan: "#7dcfff"
  readonly property color accentGreen: "#9ece6a"
  readonly property color accentOrange: "#ff9e64"
  readonly property color accentRed: "#f7768e"

  readonly property color urgencyLow: textMuted
  readonly property color urgencyNormal: accentPrimary
  readonly property color urgencyCritical: accentRed
  readonly property color batteryGood: accentGreen
  readonly property color batteryWarning: accentOrange
  readonly property color batteryCritical: accentRed
}
]]

local function module_template(name)
  -- Convert kebab-case to PascalCase for the entry point filename
  local pascal = name:gsub("(%a)([%w]*)", function(first, rest)
    return first:upper() .. rest
  end):gsub("-", "")

  local entry_point = [[import Quickshell
import QtQuick

Scope {
    id: root
    property var theme: DefaultTheme {}

    // Your module code here
}
]]
  return pascal, entry_point
end

local function widget_template(name)
  return string.format([[import QtQuick

Item {
    id: root
    property var theme

    // %s widget
}
]], name)
end

local function singleton_template(name)
  return string.format([[pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    // %s singleton
}
]], name)
end

function M.create(type, name)
  if type == "module" then
    local dir = qs_dir .. "/" .. name
    if vim.fn.isdirectory(dir) == 1 then
      vim.notify("Module directory already exists: " .. name, vim.log.levels.WARN)
      return
    end

    vim.fn.mkdir(dir, "p")

    local pascal, entry_content = module_template(name)
    local entry_path = dir .. "/" .. pascal .. ".qml"
    local theme_path = dir .. "/DefaultTheme.qml"

    local f = io.open(entry_path, "w")
    if f then
      f:write(entry_content)
      f:close()
    end

    f = io.open(theme_path, "w")
    if f then
      f:write(default_theme_template)
      f:close()
    end

    vim.notify(string.format("Created module: %s/ (%s.qml + DefaultTheme.qml)", name, pascal), vim.log.levels.INFO)
    vim.cmd("edit " .. vim.fn.fnameescape(entry_path))

  elseif type == "widget" then
    -- Create widget in current file's directory
    local current_dir = vim.fn.expand("%:p:h")
    if current_dir == "" then
      current_dir = vim.fn.getcwd()
    end

    local pascal = name:gsub("(%a)([%w]*)", function(first, rest)
      return first:upper() .. rest
    end):gsub("-", "")

    local path = current_dir .. "/" .. pascal .. ".qml"
    if vim.fn.filereadable(path) == 1 then
      vim.notify("Widget file already exists: " .. path, vim.log.levels.WARN)
      return
    end

    local f = io.open(path, "w")
    if f then
      f:write(widget_template(pascal))
      f:close()
    end

    vim.notify("Created widget: " .. pascal .. ".qml", vim.log.levels.INFO)
    vim.cmd("edit " .. vim.fn.fnameescape(path))

  elseif type == "singleton" then
    local current_dir = vim.fn.expand("%:p:h")
    if current_dir == "" then
      current_dir = vim.fn.getcwd()
    end

    local pascal = name:gsub("(%a)([%w]*)", function(first, rest)
      return first:upper() .. rest
    end):gsub("-", "")

    local path = current_dir .. "/" .. pascal .. ".qml"
    if vim.fn.filereadable(path) == 1 then
      vim.notify("Singleton file already exists: " .. path, vim.log.levels.WARN)
      return
    end

    local f = io.open(path, "w")
    if f then
      f:write(singleton_template(pascal))
      f:close()
    end

    vim.notify("Created singleton: " .. pascal .. ".qml", vim.log.levels.INFO)
    vim.cmd("edit " .. vim.fn.fnameescape(path))

  else
    vim.notify("Unknown template type: " .. type .. " (use module, widget, or singleton)", vim.log.levels.ERROR)
  end
end

return M
