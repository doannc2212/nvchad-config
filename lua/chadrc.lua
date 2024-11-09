local M = {}

M.base46 = {
  hl_add = {},
  hl_override = {},
  integrations = {},
  changed_themes = {},
  transparency = true,
  theme_toggle = { "chadracula-evondev", "one_light" },
  theme = "chadracula-evondev", -- default theme
}

M.ui = {
  cmp = {
    icons = true,
    lspkind_text = true,
    style = "atom_colored", -- default/flat_light/flat_dark/atom/atom_colored
  },

  telescope = { style = "borderless" }, -- borderless / bordered

  statusline = {
    theme = "default", -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "default",
    order = nil,
    modules = nil,
  },

  -- lazyload it when there are 1+ buffers
  tabufline = {
    enabled = true,
    lazyload = true,
    order = { "treeOffset", "buffers", "tabs", "btns" },
    modules = nil,
  },

  nvdash = {
    load_on_startup = true,

    buttons = {
      { "  Find File", "Spc Spc", "Telescope find_files" },
      { "󰈚  Recent Files", "Spc f o", "Telescope oldfiles" },
      { "󰈭  Find Word", "Spc f w", "Telescope live_grep" },
      { "  Bookmarks", "Spc m a", "Telescope marks" },
      { "  Themes", "Spc t h", "Telescope themes" },
      { "  Mappings", "Spc c h", "NvCheatsheet" },
    },
  },

  cheatsheet = {
    theme = "grid",                                            -- simple/grid
    excluded_groups = { "terminal (t)", "autopairs", "Nvim" }, -- can add group name or with mode
  },

  lsp = { signature = true },

  term = {
    hl = "Normal:term,WinSeparator:WinSeparator",
    sizes = { sp = 0.3, vsp = 0.2 },
    float = {
      relative = "editor",
      row = 0.3,
      col = 0.25,
      width = 0.5,
      height = 0.4,
      border = "single",
    },
  },

  mason = {
    cmd = true,
    pkgs = {

      "bash-language-server",

      -- golang stuff
      "gopls",

      -- lua stuff
      "lua-language-server",
      "stylua",

      -- web dev stuff
      "astro-language-server",
      "svelte-language-server",
      "css-lsp",
      "html-lsp",
      "json-language-server",
      "prettierd",
      "eslint_d",

      -- c/cpp stuff
      "clangd",
    },
  },
}

return M
