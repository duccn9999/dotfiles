vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when copy",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)

    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

vim.lsp.buf.format({ async = true })

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})


vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    local view = vim.fn.winsaveview()

    vim.lsp.buf.format()
    vim.cmd("normal! gg=G")

    vim.fn.winrestview(view)
  end,
})

vim.api.nvim_create_autocmd("QuitPre", {
  callback = function()
    local invalid_win = {}
    local wins = vim.api.nvim_list_wins()
    for _, w in ipairs(wins) do
      local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
      if bufname:match("NvimTree_") ~= nil then
	table.insert(invalid_win, w)
      end
    end
    if #invalid_win == #wins - 1 then
      -- Should quit, so we close all invalid windows.
      for _, w in ipairs(invalid_win) do vim.api.nvim_win_close(w, true) end
    end
  end
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client ~= nil and client:supports_method("text/Document/completion") then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopePrompt",
  callback = function()
    vim.opt_local.statusline = ""
  end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    local base     = "#1e1e2e"
    local mantle   = "#181825"
    local text     = "#cdd6f4"
    local crust    = "#11111b"

    local mauve    = "#cba6f7"
    local blue     = "#89b4fa"
    local green    = "#a6e3a1"
    local lavender = "#b4befe"
    local peach    = "#fab387"
    local surface1 = "#45475a"

    -- Segment fills (bg = block color)
    vim.api.nvim_set_hl(0, "StatusMode", { fg = crust, bg = mauve, bold = true })
    vim.api.nvim_set_hl(0, "StatusFile", { fg = text, bg = surface1 })
    vim.api.nvim_set_hl(0, "StatusGit", { fg = crust, bg = green, bold = true })
    vim.api.nvim_set_hl(0, "StatusType", { fg = crust, bg = lavender, bold = true })
    vim.api.nvim_set_hl(0, "StatusPos", { fg = crust, bg = peach, bold = true })

    -- Separators: fg = the segment color they're LEAVING, bg = the segment they're ENTERING
    vim.api.nvim_set_hl(0, "SepModeToFile", { fg = mauve, bg = surface1 })
    vim.api.nvim_set_hl(0, "SepFileToGit", { fg = surface1, bg = green })
    vim.api.nvim_set_hl(0, "SepGitToMid", { fg = green, bg = base })
    vim.api.nvim_set_hl(0, "SepMidToType", { fg = base, bg = lavender })
    vim.api.nvim_set_hl(0, "SepTypeToPos", { fg = lavender, bg = peach })
    vim.api.nvim_set_hl(0, "SepPosEnd", { fg = peach, bg = base })

    vim.api.nvim_set_hl(0, "StatusLine", { fg = text, bg = base })
    vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "#7f849c", bg = mantle })
  end,
})
