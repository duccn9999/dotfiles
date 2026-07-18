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
		vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
	end,
})
