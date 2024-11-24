-- ~/.config/nvim/lua/daniel/cmp.lua

-- Set up nvim-cmp for code completion
local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
	-- Define completion sources
	sources = {
		{ name = "nvim_lsp" }, -- LSP-based completion
		{ name = "buffer" }, -- Text within the buffer
		{ name = "path" }, -- File path completion
	},
	-- Formatting options with lspkind for icons
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text", -- Display both symbol and text
			maxwidth = 80, -- Limit max width of completion items
		}),
	},
	-- Key mappings for navigating and selecting completion items
	mapping = {
		["<C-n>"] = cmp.mapping.select_next_item(), -- Next item
		["<C-p>"] = cmp.mapping.select_prev_item(), -- Previous item
		["<Tab>"] = cmp.mapping.select_next_item(), -- Tab to next
		["<S-Tab>"] = cmp.mapping.select_prev_item(), -- Shift-Tab to previous
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Enter to confirm
	},
	-- Customization of completion and documentation windows
	window = {
		completion = {
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, -- Border style
			winhighlight = "Normal:CmpDoc,FloatBorder:CmpBorder,Search:None", -- Highlights
			col_offset = -3, -- Adjust tooltip position
			side_padding = 1, -- Space around tooltip
		},
		documentation = {
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, -- Documentation border
			winhighlight = "Normal:CmpDoc,FloatBorder:CmpBorder,Search:None", -- Documentation highlights
		},
	},
})
