local M = {}

local qs_dir = vim.fn.expand("~/.config/quickshell")

local theme_props = {
  { key = "bgBase", label = "Background Base" },
  { key = "bgSurface", label = "Background Surface" },
  { key = "bgHover", label = "Background Hover" },
  { key = "bgSelected", label = "Background Selected" },
  { key = "bgBorder", label = "Background Border" },
  { key = "textPrimary", label = "Text Primary" },
  { key = "textSecondary", label = "Text Secondary" },
  { key = "textMuted", label = "Text Muted" },
  { key = "accentPrimary", label = "Accent Primary" },
  { key = "accentCyan", label = "Accent Cyan" },
  { key = "accentGreen", label = "Accent Green" },
  { key = "accentOrange", label = "Accent Orange" },
  { key = "accentRed", label = "Accent Red" },
}

local function read_theme_index()
  local conf_path = qs_dir .. "/theme.conf"
  local f = io.open(conf_path, "r")
  if not f then
    return 0
  end
  local content = f:read("*a")
  f:close()
  return tonumber(vim.trim(content)) or 0
end

local function load_themes_json()
  local json_path = qs_dir .. "/theme-switcher/themes.json"
  local f = io.open(json_path, "r")
  if not f then
    return nil
  end
  local content = f:read("*a")
  f:close()
  local ok, themes = pcall(vim.json.decode, content)
  if not ok then
    return nil
  end
  return themes
end

function M.show()
  local themes = load_themes_json()
  if not themes then
    vim.notify("Could not load themes.json", vim.log.levels.ERROR)
    return
  end

  local idx = read_theme_index()
  -- themes.json is 0-indexed from QML, Lua tables are 1-indexed
  local theme = themes[idx + 1]
  if not theme then
    vim.notify("Theme index " .. idx .. " out of range", vim.log.levels.ERROR)
    return
  end

  local lines = {}
  local highlights = {}

  table.insert(lines, string.format("  Theme: %s (%s)", theme.name, theme.family))
  table.insert(lines, string.format("  Index: %d / %d", idx, #themes - 1))
  table.insert(lines, "")

  local ns = vim.api.nvim_create_namespace("quickshell_theme_preview")

  for i, prop in ipairs(theme_props) do
    local color = theme[prop.key]
    if color then
      local swatch = "  ██████"
      local line = string.format("%s  %-20s  %s", swatch, prop.label, color)
      table.insert(lines, line)
      table.insert(highlights, { line = #lines - 1, color = color, col_start = 0, col_end = 8 })
    end
  end

  table.insert(lines, "")
  table.insert(lines, "  Press q to close")

  -- Create floating window
  local width = 50
  local height = #lines
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
    style = "minimal",
    border = "rounded",
    title = " Quickshell Theme ",
    title_pos = "center",
  })

  -- Apply color highlights
  for _, hl in ipairs(highlights) do
    local hl_group = "QsTheme_" .. hl.color:gsub("#", "")
    vim.api.nvim_set_hl(0, hl_group, { fg = hl.color })
    vim.api.nvim_buf_add_highlight(buf, ns, hl_group, hl.line, hl.col_start, hl.col_end)
  end

  -- Title line highlight
  local title_hl = "QsTheme_title"
  vim.api.nvim_set_hl(0, title_hl, { fg = theme.accentPrimary, bold = true })
  vim.api.nvim_buf_add_highlight(buf, ns, title_hl, 0, 0, -1)

  -- Buffer options
  vim.bo[buf].modifiable = false
  vim.bo[buf].bufhidden = "wipe"

  -- Close keymaps
  vim.keymap.set("n", "q", function()
    vim.api.nvim_win_close(win, true)
  end, { buffer = buf })
  vim.keymap.set("n", "<Esc>", function()
    vim.api.nvim_win_close(win, true)
  end, { buffer = buf })
end

return M
