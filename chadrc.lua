-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

local M = {}

M.ui = {
  theme = "chadracula-evondev",
  theme_toggle = { "chadracula-evondev", "rosepine-dawn" },
  transparency = true,

  nvdash = {
    load_on_startup = true,
  },
  cmp = {
    style = "atom_colored", -- default/flat_light/flat_dark/atom/atom_colored
  },
}

return M
