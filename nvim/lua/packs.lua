--[[ autopairs ]]
vim.pack.add({
  { src = "https://github.com/windwp/nvim-autopairs" },
})
require("nvim-autopairs").setup()
--[[ bufferline ]]
vim.pack.add({
  'https://github.com/nvim-tree/nvim-web-devicons',
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
	["<C-k>"] = require("telescope.actions").move_selection_previous,
	["<C-j>"] = require("telescope.actions").move_selection_next,
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
  "json",
  "cpp"
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


-- [[ snippet / completion ]]
vim.pack.add({ "https://github.com/saghen/blink.lib", "https://github.com/saghen/blink.cmp" })
local cmp = require("blink.cmp")
cmp.build()
cmp.setup({
  keymap = {
    preset = "none",
    ['<Tab>'] = { "accept", "fallback" },
    ['<CR>'] = { "accept", "fallback" },
    ['<C-k>'] = { 'select_prev', 'fallback' },
    ['<C-j>'] = { 'select_next', 'fallback' },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" }
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },
  completion = {
    documentation = { auto_show = true }
  }
})



vim.pack.add({ "https://github.com/vyfor/cord.nvim" })
require('cord').setup {
  advanced = {
    discord = {
      reconnect = {
	enabled = true,
      },
    },
  },
  display = {
    theme = 'catppuccin',
    view = 'full'
  },
}



vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })
require('gitsigns').setup {
  signs                        = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signs_staged                 = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signs_staged_enable          = true,
  signcolumn                   = true,     -- Toggle with `:Gitsigns toggle_signs`
  numhl                        = false,    -- Toggle with `:Gitsigns toggle_numhl`
  linehl                       = false,    -- Toggle with `:Gitsigns toggle_linehl`
  word_diff                    = false,    -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir                 = {
    follow_files = true
  },
  auto_attach                  = true,
  attach_to_untracked          = false,
  current_line_blame           = false,    -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts      = {
    virt_text = true,
    virt_text_pos = 'eol',    -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
    use_focus = true,
  },
  current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
  blame_formatter              = nil,    -- Use default
  sign_priority                = 6,
  update_debounce              = 100,
  status_formatter             = nil,      -- Use default
  max_file_length              = 40000,    -- Disable if file is longer than this (in lines)
  preview_config               = {
    -- Options passed to nvim_open_win
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
}
