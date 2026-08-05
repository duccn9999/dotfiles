vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.shiftwidth = 2
vim.opt.ignorecase = true
vim.opt.autowrite = true
vim.opt.icon = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.updatetime = 250
vim.opt.showmode = false
vim.lsp.enable("lua_ls")
vim.lsp.enable("vtsls")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("clangd")
vim.lsp.enable("gopls")
vim.diagnostic.config({
  virtual_text = true, -- disable so it doesn't show both
})
require("packs")
require("tabline")
require("keymaps")
require("autocmds")
require("tree")
require("terminal")
require("statusline")
vim.cmd.colorscheme("catppuccin")
