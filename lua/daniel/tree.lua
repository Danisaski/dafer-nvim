-- ~/.config/nvim/lua/daniel/tree.lua
require("nvim-tree").setup({
	view = {
		width = 30,
		side = "left"
	},
	filters = {
		dotfiles = false
	},
	renderer = {
		highlight_git = true,
		icons = {
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true
			}
		}
	},
    actions = {
        open_file = {
            quit_on_open = true,
        }
    }
})
