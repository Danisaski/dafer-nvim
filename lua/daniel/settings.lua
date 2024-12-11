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

vim.o.updatetime = 300 -- 300ms is a common sweet spot
vim.o.cursorline = true
vim.o.cursorlineopt = 'both'

-- Enable relative line numbers
vim.wo.relativenumber = true
vim.wo.number = true                                                             -- Ensure absolute line number for the current line

vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#FF0000", bold = true })         -- Red dot
vim.api.nvim_set_hl(0, "DapBreakpointRejected", { fg = "#FFA500", bold = true }) -- Orange for rejected breakpoints
vim.api.nvim_set_hl(0, "DapStopped", { fg = "#00FF00", bold = true })            -- Green for current line
vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#003300" })                     -- Background for stopped line
