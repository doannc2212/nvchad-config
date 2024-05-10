require "nvchad.options"


local o = vim.opt
local autocmd = vim.api.nvim_create_autocmd

autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

o.relativenumber = true
o.updatetime = 100

vim.g.clipboard = {
  name = 'WslClipboard',
  copy = {
    ['+'] = 'clip.exe',
    ['*'] = 'clip.exe',
  },
  paste = {
    ['+'] = 'pwsh.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    ['*'] = 'pwsh.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
  },
  cache_enabled = 0,
}
