-- ~/.config/nvim/lua/user/lspconfig.lua
local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

-- Ensure that nvim-cmp can autocomplete LSP items
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Set up Pyright for Python
lspconfig.pyright.setup({
  capabilities = capabilities,  -- Enable autocomplete capabilities
  on_attach = function(client, bufnr)
    -- Key mappings for LSP functions
    local opts = { noremap = true, silent = true }

    -- LSP function mappings
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gh", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  end,
})
