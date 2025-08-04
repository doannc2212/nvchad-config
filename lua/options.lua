require "nvchad.options"
local funcs = require "funcs"

local o = vim.opt
local autocmd = vim.api.nvim_create_autocmd

autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

o.relativenumber = true
o.updatetime = 100

-- golang org import on save
autocmd("BufWritePre", {
  pattern = "*.go",
  callback = funcs.organize_imports,
})
