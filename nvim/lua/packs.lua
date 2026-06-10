--[[ autopairs ]]
vim.pack.add({
  { src = "https://github.com/windwp/nvim-autopairs" },
})
require("nvim-autopairs").setup()
--[[ bufferline ]]
vim.pack.add({
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
})
--[[ lualine ]]
vim.pack.add({
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
})
require("lualine").setup({})
--[[ telescope ]]
vim.pack.add({
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
})
require("telescope").setup({
  defaults = {
    preview = {
      treesitter = true
    },
    mappings = {
      i = {
	["<C-,>"] = require("telescope.actions").move_selection_previous,
	["<C-.>"] = require("telescope.actions").move_selection_next,
      },
    }
  }
})
--[[ tree sitter ]]
vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})
local treesitter = require("nvim-treesitter")
local languages = {
  "bash",
  "css",
  "dockerfile",
  "go",
  "html",
  "javascript",
  "json",
  "lua",
  "markdown",
  "python",
  "sql",
  "typescript",
  "yaml",
  "rust",
  "json"
}
treesitter.setup({
  highlight = { enable = true },
  indent = { enable = true },
})
treesitter.install(languages)
vim.api.nvim_create_autocmd("FileType", {
  pattern = languages,
  callback = function()
    vim.treesitter.start()
  end,
})

--[[ lsp ]]
vim.pack.add({
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
})
require("mason").setup({})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      format = {
	enable = true,
      },
    },
  },
})

vim.lsp.config("rust_analyzer", {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml" },
  settings = {
    ["rust-analyzer"] = {},
  },
})
vim.lsp.enable("lua_ls")
vim.lsp.enable("ts_ls")
vim.lsp.enable("rust_analyzer")

-- [[ snippet / completion ]]
vim.pack.add({ "https://github.com/saghen/blink.lib", "https://github.com/saghen/blink.cmp" })
local cmp = require("blink.cmp")
cmp.build():pwait()
cmp.setup({
  keymap = {
    preset = "none",

    ['<C-,>'] = { 'select_prev', 'fallback' },
    ['<C-.>'] = { 'select_next', 'fallback' },

    ['<Tab>'] = { "accept", "fallback" },
    ['<CR>'] = { "accept", "fallback" },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" }
  },
  fuzzy = { implementation = "prefer_rust_with_warning" }
})
