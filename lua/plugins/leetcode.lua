local home_dir = vim.fn.expand "$HOME"
return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  lazy = "leetcode" ~= vim.fn.argv(0, -1),
  dependencies = { "MunifTanjim/nui.nvim" },
  cmd = "Leet",
  opts = {
    arg = "leetcode",
    lang = "typescript",
    storage = {
      -- home = vim.fn.stdpath "data" .. "/leetcode",
      home = home_dir .. "/leetcode",
      cache = home_dir .. "/leetcode",
      -- cache = vim.fn.stdpath "cache" .. "/leetcode",
    },
    picker = { provider = "telescope" },
  },
}
