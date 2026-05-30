vim.g.mapleader = " "
vim.g.maplocalleader = "\\"


vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.shiftwidth = 2
vim.opt.ignorecase = true
vim.opt.autowrite = true
vim.opt.autocomplete = true
vim.opt.guifont = "JetBrainsMono Nerd Font Mono"
vim.opt.icon = true
vim.cmd.colorscheme("habamax")

vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
require("config.lazy")
