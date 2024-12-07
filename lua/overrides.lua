local M = {}

M.treesitter = {
  ensure_installed = {
    "astro",
    "bash",
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "markdown",
    "markdown_inline",
    "vue",
    "go",
    "svelte",
  },
  highlight = { enable = true },
  autotag = {
    -- https://github.com/windwp/nvim-ts-autotag/issues/191#issuecomment-2161689614
    enable = false,
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
  -- context_commentstring = {
  --   enable = true,
  -- },
}

-- git support in nvimtree
M.nvimtree = {
  git = { enable = true },

  view = {
    adaptive_size = true,
    side = "left",
  },

  renderer = {
    highlight_git = true,
    icons = { show = { git = true } },
  },
}

-- Discord presence
M.presence = {
  auto_update = true,
  log_level = nil,
  debounce_timeout = 5,
  enable_line_number = true,
  buttons = true,
  show_time = true,
  -- Rich Presence text options
  editing_text = "Editing %s",
  file_explorer_text = "Browsing %s",
  git_commit_text = "Committing changes",
  plugin_manager_text = "Managing plugins",
  reading_text = "Reading %s",
  workspace_text = "Working on %s",
  line_number_text = "Line %s out of %s",
}

M.copilot = {
  -- Possible configurable fields can be found on:
  -- https://github.com/zbirenbaum/copilot.lua#setup-and-configuration
  panel = {
    enabled = true,
    auto_refresh = false,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<M-CR>",
    },
    layout = {
      position = "bottom", -- | top | left | right
      ratio = 0.4,
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 75,
    keymap = {
      accept = "<M-l>",
      accept_word = false,
      accept_line = false,
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
  },
  filetypes = {
    yaml = false,
    markdown = false,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
  copilot_node_command = "node", -- Node.js version must be > 16.x
  -- server_opts_overrides = {},
}

M.spectre = {
  open_cmd = "noswapfile vnew",
}

M.leetcode = {
  --
}

return M
