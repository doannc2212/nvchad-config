require "nvchad.options"

local o = vim.opt
local autocmd = vim.api.nvim_create_autocmd

autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

o.relativenumber = true
o.updatetime = 100
