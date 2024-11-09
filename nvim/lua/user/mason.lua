-- ~/.config/nvim/lua/user/mason.lua

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "pyright", "ruff"}, -- Add other LSP servers as needed
})

-- Setup for other tools
require("mason-tool-installer").setup({
    ensure_installed = { "black", "debugpy", "mypy" }, -- Add other non-LSP tools as needed
    auto_update = true, -- Automatically update installed tools
    run_on_start = true, -- Run the installer on startup
})
