-- ~/.config/nvim/lua/daniel/mason.lua
require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = {
        "pyright", "ruff", -- Python
        "lua_ls",          -- Lua
        "rust_analyzer",   -- Rust
        "clangd",          -- C/C++
        "marksman",        -- Markdown
        -- "cssls"            -- css
        -- "zls",             -- Zig
        -- "gopls",           -- Go
        -- "ts_ls",           -- Typescritp/JS
        -- "texlab",          -- English grammar, LaTeX, and Markdown
        -- "ltex",            -- English grammar, LaTeX, and Markdown
    },
    handlers = {
        function(server_name)
            -- Default configuration
            require('lspconfig')[server_name].setup({})
        end
    }
})
