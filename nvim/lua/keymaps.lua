vim.keymap.set("n", "<C-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<C-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<C-q>", "<cmd>bdelete<CR>", { desc = "Delete tab" })
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select all" })
vim.keymap.set("n", "<C-t>", "<cmd>term<CR>", { desc = "Open terminal" })
vim.keymap.set("n", "<leader>e", "<cmd>:Ex<CR>", { desc = "Open tree" })
vim.keymap.set("n", "<F12>", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end,
{ desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope.find_files, {
  desc = "Telescope find files",
})
vim.keymap.set("n", "<leader>fg", telescope.live_grep, {
  desc = "Telescope live grep",
})
vim.keymap.set("n", "<leader>fb", telescope.buffers, {
  desc = "Telescope buffers",
})
vim.keymap.set("n", "<leader>fh", telescope.help_tags, {
  desc = "Telescope help tags",
})
vim.keymap.set("n", "<leader>fd", telescope.diagnostics, {
  desc = "Telescope show diagnostics",
})
