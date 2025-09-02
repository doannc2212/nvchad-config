-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvchad/options.lua
require "nvchad.options"

vim.api.nvim_create_autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

vim.o.relativenumber = true
vim.o.updatetime = 100
