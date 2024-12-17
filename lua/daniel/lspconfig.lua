-- ~/.config/nvim/lua/daniel/lspconfig.lua
local capabilities = require('blink.cmp').get_lsp_capabilities()
local lspconfig = require('lspconfig')

-- Define servers and their configurations
local servers = {
  lua_ls = {},           -- Lua Language Server
  pyright = {},          -- Python LSP
  ruff = {},             -- Ruff Linter (LSP mode)
  rust_analyzer = {},    -- Rust Language Server
}

-- Setup each server with capabilities
for server, config in pairs(servers) do
  config.capabilities = vim.tbl_deep_extend("force", config.capabilities or {}, capabilities)
  lspconfig[server].setup(config)
end

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        vim.keymap.set('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<cr>', {buffer = event.buf, desc = "Hover"})
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', {buffer = event.buf, desc = "Go to definition"})
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', {buffer = event.buf, desc = "Go to declaration"})
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', {buffer = event.buf, desc = "Go to implementation"})
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', {buffer = event.buf, desc = "Go to type definition"})
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', {buffer = event.buf, desc = "Go to references"})
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', {buffer = event.buf, desc = "Signature help"})
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', {buffer = event.buf, desc = "Rename"})
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', {buffer = event.buf, desc = "Code actions"})
    end
})
