vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.shiftwidth = 2
vim.opt.ignorecase = true
vim.opt.autowrite = true
vim.opt.guifont = "JetBrains Mono Nerd Font"
vim.opt.icon = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.updatetime = 250
vim.diagnostic.config({
  update_in_insert = true,
  virtual_text = true, -- disable so it doesn't show both
})
require("packs")
require("tabline")
require("keymaps")
require("autocmds")
vim.cmd.colorscheme("catppuccin")
