-- Function to show line diagnostics
local function show_line_diagnostics()
	vim.diagnostic.open_float(nil, {
		focusable = false,
		scope = "line",
		border = "rounded",
	})
end

-- Auto-trigger on CursorHold
vim.api.nvim_create_autocmd("CursorHold", {
	callback = show_line_diagnostics,
	desc = "Show line diagnostics in a floating window",
})

-- Keybinding to go to the next diagnostic in Normal and Visual mode
vim.keymap.set({ 'n', 'x' }, '<leader>d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })

-- Keybinding to go to the previous diagnostic in Normal and Visual mode
vim.keymap.set({ 'n', 'x' }, '<leader>e', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
