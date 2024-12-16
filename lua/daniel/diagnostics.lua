-- Function to show line diagnostics only if no other floating window is open
local function show_line_diagnostics()
	if #vim.api.nvim_list_wins() == 1 then
		vim.diagnostic.open_float(nil, {
			focusable = false,
			scope = "line",
			border = "rounded",
		})
	end
end
-- Auto-trigger on CursorHold
vim.api.nvim_create_autocmd("CursorHold", {
	callback = show_line_diagnostics,
	desc = "Show line diagnostics in a floating window",
})

-- Keybinding to go to the next diagnostic in Normal and Visual mode
vim.keymap.set({ 'n', 'x' }, '<leader>e', vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })

-- Keybinding to go to the previous diagnostic in Normal and Visual mode
vim.keymap.set({ 'n', 'x' }, '<leader>E', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
