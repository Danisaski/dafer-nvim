-- ~/.config/nvim/lua/user/diagnostics.lua

local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.diagnostics.ruff,
		null_ls.builtins.diagnostics.mypy,
		-- Add other diagnostics if needed
	},
})
