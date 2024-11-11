-- ~/.config/nvim/lua/user/tree.lua

require("nvim-tree").setup({
	view = {
		width = 30,
		side = "left",
	},
	filters = {
		dotfiles = false,
	},
	renderer = {
		highlight_git = true,
		icons = {
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},
		},
	},
})

-- Keymap to toggle the tree view
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { silent = true, noremap = true })
