-- ~/.config/nvim/lua/user/telescope.lua

require("telescope").setup({
	defaults = {
		mappings = {
			i = { ["<esc>"] = require("telescope.actions").close },
		},
	},
})

-- Keybinding to trigger Telescope
vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep, { desc = "Live Grep" })
