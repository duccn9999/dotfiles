return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
  local configs = require('nvim-treesitter')
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
    }
  configs.setup({
    highlight = { enable = true },
    indent = { enable = true },
    autotage = { enable = true },
  })
  configs.install(languages)
  end,
}
