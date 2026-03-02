local M = {}

local ns = vim.api.nvim_create_namespace("quickshell_diagnostics")

local rules = {
  {
    pattern = "sourceSize",
    context_pattern = "IconImage",
    severity = vim.diagnostic.severity.ERROR,
    message = "IconImage has no sourceSize -- use implicitSize instead",
    context_range = 10,
  },
  {
    pattern = "%.text[^%(]",
    context_pattern = "FileView",
    severity = vim.diagnostic.severity.WARN,
    message = "FileView.text() is a method -- call with ()",
    context_range = 15,
  },
  {
    pattern = "%.text%(%)",
    context_pattern = "StdioCollector",
    severity = vim.diagnostic.severity.WARN,
    message = "StdioCollector.text is a property -- don't call with ()",
    context_range = 15,
  },
  {
    pattern = "expireTimeout:%s*(%d+)",
    severity = vim.diagnostic.severity.WARN,
    message = "expireTimeout is in seconds, not milliseconds -- value seems too large",
    check = function(match)
      local val = tonumber(match)
      return val and val > 1000
    end,
  },
}

local function check_context(lines, line_idx, context_pattern, range)
  local start = math.max(0, line_idx - range)
  local stop = math.min(#lines, line_idx + range)
  for i = start, stop do
    if lines[i] and lines[i]:find(context_pattern) then
      return true
    end
  end
  return false
end

local function lint(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local diagnostics = {}

  for line_idx, line in ipairs(lines) do
    for _, rule in ipairs(rules) do
      local match_start, match_end, capture = line:find(rule.pattern)
      if match_start then
        local valid = true

        -- Check context pattern if required
        if rule.context_pattern then
          valid = check_context(lines, line_idx, rule.context_pattern, rule.context_range or 10)
        end

        -- Check custom validation
        if valid and rule.check then
          valid = rule.check(capture)
        end

        if valid then
          table.insert(diagnostics, {
            lnum = line_idx - 1,
            col = match_start - 1,
            end_col = match_end,
            severity = rule.severity,
            message = rule.message,
            source = "quickshell",
          })
        end
      end
    end
  end

  vim.diagnostic.set(ns, bufnr, diagnostics)
end

function M.setup()
  local group = vim.api.nvim_create_augroup("QuickshellDiagnostics", { clear = true })

  vim.api.nvim_create_autocmd({ "BufWritePost", "TextChanged", "InsertLeave" }, {
    group = group,
    pattern = "*.qml",
    callback = function(ev)
      lint(ev.buf)
    end,
  })

  -- Also lint on BufEnter for immediate feedback
  vim.api.nvim_create_autocmd("BufEnter", {
    group = group,
    pattern = "*.qml",
    callback = function(ev)
      lint(ev.buf)
    end,
  })
end

return M
