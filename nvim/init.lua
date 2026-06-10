vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.shiftwidth = 2
vim.opt.ignorecase = true
vim.opt.autowrite = true
vim.opt.guifont = "JetBrainsMono Nerd Font Mono"
vim.opt.icon = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.diagnostic.config({
  vitual_text = true,
})
-- [[ theme ]]
vim.cmd.colorscheme("retrobox")
require("packs")
require("tabline")
require("keymaps")
require("autocmds")
