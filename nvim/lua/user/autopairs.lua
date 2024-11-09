-- ~/.config/nvim/lua/user/autopairs.lua

require("nvim-autopairs").setup({check_ts =false, -- Check treesitter for additional language support
	disable_in_macro = false, -- Enable autopairs in macros
	enable_check_bracket_line = true, -- Check if we are in the right line for pairing
	map_cr = true, -- Map <CR> to auto-pair (close pairs after pressing Enter)
	map_complete = true, -- Allow autopairs to trigger completions

	})
