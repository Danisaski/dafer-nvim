-- ~/.config/nvim/lua/user/plugins.lua

require("lazy").setup({
	-- Plugin Manager
	"folke/lazy.nvim",

	-- Mason for managing LSP servers and tools
	"williamboman/mason.nvim",
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		requires = { "williamboman/mason.nvim" },
	},
	"williamboman/mason-lspconfig.nvim",

	"kyazdani42/nvim-web-devicons",

	-- LSP Configurations
	"neovim/nvim-lspconfig",

	{
		"hrsh7th/nvim-cmp",
		config = function()
			require("user.cmp") -- You'll define the configuration here
		end,
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({}) -- Basic configuration
		end,
	},
	"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"saadparwaiz1/cmp_luasnip", -- Snippet support for nvim-cmp
	"L3MON4D3/LuaSnip", -- Snippet engine
	"onsails/lspkind-nvim", -- Prettier snippets and tooltips

	-- Null-ls for formatters and linters
	"jose-elias-alvarez/null-ls.nvim",

	-- Telescope for fuzzy finding
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- nvim-tree for file explorer
	{
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icons
		},
		config = function()
			require("user.tree")
		end,
	},

	-- Themes
	"catppuccin/nvim",

	{
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true }, -- Optional for icons
	},

	-- Additional Plugins can be added here
})
