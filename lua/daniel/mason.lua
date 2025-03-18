-- ~/.config/nvim/lua/daniel/mason.lua
require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = {
        "pyright", "ruff", -- Python
        "lua_ls",          -- Lua
        "rust_analyzer",   -- Rust
        "clangd",          -- C/C++
        -- "gopls",           -- Go
        "zls",             -- Zig
        "texlab",
        "ltex",            -- English grammar, LaTeX, and Markdown
        "marksman"         -- Markdown
    },
    handlers = {
        function(server_name)
            -- Default configuration
            require('lspconfig')[server_name].setup({})
        end
    }
})

-- Setup for other tools
require("mason-tool-installer").setup({
    ensure_installed = {
        "debugpy",      -- Existing tools
    },
    auto_update = true, -- Automatically update installed tools
    run_on_start = true -- Run the installer on startup
})
