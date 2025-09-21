-- ~/.config/nvim/lua/daniel/mason.lua
require("mason").setup()

-- Define the servers that should be auto-installed by Mason
local servers = {
    "lua_ls",   -- Lua Language Server
    "pyright",  -- Python Language Server
    "ruff",     -- Ruff Linter (LSP mode)
    "marksman", -- Markdown Language Server
    "clangd",   -- C Language Server
    "cssls",    -- CSS Language Server
    "texlab",   -- Another LaTeX Language Server
}

require("mason-lspconfig").setup({
    ensure_installed = servers,
})
