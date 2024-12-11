-- ~/.config/nvim/lua/daniel/telescope.lua

require("telescope").setup({
	defaults = {
		mappings = {
			i = { ["<esc>"] = require("telescope.actions").close },
		},
	},
})
