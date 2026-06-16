--[[ autopairs ]]
vim.pack.add({
  { src = "https://github.com/windwp/nvim-autopairs" },
})
require("nvim-autopairs").setup()
--[[ bufferline ]]
vim.pack.add({
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-lualine/lualine.nvim'
})

local function mode_icon()
  local mode_map = {
    ['n'] = '\u{f121} ', -- NORMAL
    ['i'] = '\u{f11c} ', -- INSERT
    ['v'] = '\u{f0168} ', -- VISUAL
    ['V'] = '\u{f0168} ', -- VISUAL LINE
    [''] = ' ', -- VISUAL BLOCK
    ['c'] = '\u{f120} ', -- COMMAND
    ['r'] = '\u{f044} ', -- REPLACE
    ['t'] = '\u{f120} ', -- TERMINAL
  }
  local mode = vim.fn.mode()
  return mode_map[mode] or ''
end
require("lualine").setup({
  options = {
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {
      { mode_icon, padding = { left = 1, right = 0 } },
      'mode'
    },
    lualine_c = {
      {
	'filename',
	color = { gui = 'bold' }
      }
    }
  }
})
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
cmp.build()
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
  fuzzy = { implementation = "prefer_rust_with_warning" },
  completion = {
    documentation = { auto_show = true }
  }
})
