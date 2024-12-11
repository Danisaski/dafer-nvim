-- ~/.config/nvim/lua/daniel/mason.lua
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "pyright", "ruff", 'lua_ls', 'rust_analyzer' }, -- Add other LSP servers as needed
	handlers = { function(server_name)
		require('lspconfig')[server_name].setup({})
	end }
})

-- Setup for other tools
require("mason-tool-installer").setup({
	ensure_installed = { "debugpy" }, -- Add other non-LSP tools as needed
	auto_update = true,        -- Automatically update installed tools
	run_on_start = true        -- Run the installer on startup
})
