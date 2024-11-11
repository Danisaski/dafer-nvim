-- ~/.config/nvim/lua/user/formatters.lua

-- Ensure you have null-ls configured properly
local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.black, -- Black for Python formatting
		null_ls.builtins.formatting.stylua, -- Stylua for Lua formatting
	},
})

-- Automatically format on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.py", -- For Python files
	callback = function()
		vim.lsp.buf.format() -- This is the correct method for formatting
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.lua", -- For Lua files
	callback = function()
		vim.lsp.buf.format() -- This is the correct method for formatting
	end,
})
