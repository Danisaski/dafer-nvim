-- ~/.config/nvim/lua/daniel/mason.lua
require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = {
        "pyright", "ruff", -- Python
        "lua_ls",          -- Lua
        "rust_analyzer",   -- Rust
        "clangd",          -- C/C++
        -- "gopls",           -- Go
        "ts_ls",           -- Typescritp/JS
        "zls",             -- Zig
        "texlab",
        "ltex",            -- English grammar, LaTeX, and Markdown
        "marksman",        -- Markdown
        "cssls"            -- css
    },
    handlers = {
        function(server_name)
            -- Default configuration
            require('lspconfig')[server_name].setup({})
        end
    }
})
