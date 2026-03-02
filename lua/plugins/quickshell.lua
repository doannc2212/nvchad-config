return {
  dir = vim.fn.stdpath("config"),
  name = "quickshell",
  ft = "qml",
  cmd = { "Qs", "QsRestart", "QsLogs", "QsNew", "QsTheme" },
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("quickshell").setup()
  end,
}
