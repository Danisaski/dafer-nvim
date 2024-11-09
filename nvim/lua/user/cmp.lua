-- Set up nvim-cmp for completion
local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
	sources = {
		{ name = "nvim_lsp" }, -- Use LSP for completion
		{ name = "luasnip" }, -- Snippet completion
		{ name = "buffer" },
		{ name = "path" },
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	formatting = {
		-- Use lspkind for adding icons
		format = lspkind.cmp_format({
			mode = "symbol_text", -- Show both text and icons
			maxwidth = 80, -- Set max width of completion items
		}),
	},
	mapping = {
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<S-Tab>"] = cmp.mapping.select_prev_item(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection on Enter
	},

	window = {
		-- Customization of completion window
		completion = {
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, -- Nice border
			winhighlight = "Normal:CmpDoc,FloatBorder:CmpBorder,Search:None", -- Highlight settings
			col_offset = -3, -- Control tooltip position
			side_padding = 1, -- Space on the side of the tooltip
		},
		documentation = {
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, -- Nice border for documentation
			winhighlight = "Normal:CmpDoc,FloatBorder:CmpBorder,Search:None", -- Documentation window highlight
		},
	},
	sources = {
		{ name = "nvim_lsp" }, -- Use LSP for completion
		{ name = "luasnip" }, -- Snippet completion
	},
})
