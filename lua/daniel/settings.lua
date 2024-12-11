-- ~/.config/nvim/lua/daniel/settings.lua

-- Automatically save the file when leaving insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	callback = function()
		-- Check the buffer type
		if vim.bo.buftype == "" then
			vim.cmd("write") -- Write only if it's a normal buffer
		end
	end,
})


vim.o.cursorlineopt = 'both'

-- Enable relative line numbers
vim.wo.relativenumber = true
vim.wo.number = true -- Ensure absolute line number for the current line
