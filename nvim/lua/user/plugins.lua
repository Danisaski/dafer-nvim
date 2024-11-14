-- ~/.config/nvim/lua/user/plugins.lua

-- Set up lazy.nvim as the plugin manager
require("lazy").setup({
	-- Plugin Manager
	"folke/lazy.nvim",

	-- **LSP and Tooling Management**
	"williamboman/mason.nvim", -- LSP server manager
	"williamboman/mason-lspconfig.nvim", -- Integrates Mason with lspconfig
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" }, -- Ensures mason.nvim is loaded first
	},

	-- **LSP Configuration**
	"neovim/nvim-lspconfig", -- Native LSP configuration

	-- **Completion and Snippets**
	{
		"hrsh7th/nvim-cmp", -- Completion engine
		config = function()
			require("user.cmp") -- Custom completion configuration
		end,
	},
	"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
	"hrsh7th/cmp-buffer", -- Buffer source for nvim-cmp
	"hrsh7th/cmp-path", -- Path source for nvim-cmp
	"saadparwaiz1/cmp_luasnip", -- Snippet source for nvim-cmp
	"L3MON4D3/LuaSnip", -- Snippet engine
	"onsails/lspkind-nvim", -- Icons and labels for completion menu

	-- **Auto Pairs**
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({}) -- Basic auto-pairs setup
		end,
	},

	-- **Formatting and Linting**
	"jose-elias-alvarez/null-ls.nvim", -- External formatters and linters

	-- **File Icons**
	"kyazdani42/nvim-web-devicons", -- File icons for plugins

	-- **Fuzzy Finder**
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" }, -- Telescope dependencies
	},

	-- **File Explorer**
	{
		"kyazdani42/nvim-tree.lua", -- File tree explorer
		dependencies = { "kyazdani42/nvim-web-devicons" }, -- Optional: File icons
		config = function()
			require("user.tree") -- Custom tree configuration
		end,
	},

	-- **Buffer Line**
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim", -- Optional: Git integration
			"nvim-tree/nvim-web-devicons", -- Optional: File icons
		},
	},

	-- **Git Integration**
	"lewis6991/gitsigns.nvim", -- Shows git changes in sign column

	-- **Keybinding Helper**
	{
		"folke/which-key.nvim", -- Visual keybinding prompt
		config = function()
			require("which-key").setup({})
		end,
	},

	-- **Status Line**
	{
		"nvim-lualine/lualine.nvim", -- Status line plugin
		dependencies = { "kyazdani42/nvim-web-devicons" }, -- Optional: Icons
	},

	-- **Themes**
	"catppuccin/nvim", -- Catppuccin theme

	-- Additional Plugins can be added below as needed
})
