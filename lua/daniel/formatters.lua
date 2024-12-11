local lsp = require('lsp-zero')
local format_augroup = vim.api.nvim_create_augroup('LspFormatting', {})

lsp.on_attach(function(client, bufnr)
	-- Only attach formatting autocmd if the LSP client supports it
	if client.supports_method('textDocument/formatting') then
		vim.api.nvim_clear_autocmds({
			group = format_augroup,
			buffer = bufnr
		})
		vim.api.nvim_create_autocmd('BufWritePre', {
			group = format_augroup,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({
					bufnr = bufnr,
					filter = function(c)
						return c.name == client.name
					end
				})
			end
		})
	end
end)
