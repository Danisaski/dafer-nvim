-- ~/.config/nvim/lua/daniel/plugins.lua
-- Set up lazy.nvim as the plugin manager
require("lazy").setup({
	-- **Plugin Manager**
	"folke/lazy.nvim",

	-- **LSP and Tooling Management**
	{
		"VonHeikemen/lsp-zero.nvim",
		dependencies = {
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				dependencies = { "williamboman/mason.nvim" },
			},
			{ "hrsh7th/nvim-cmp",    config = function() require("daniel.cmp") end },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "onsails/lspkind-nvim" },
		},
	},

	-- **Treesitter**
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},

	-- **Git Integration**
	{
		"lewis6991/gitsigns.nvim",
		config = function() require("gitsigns").setup() end,
	},

	-- **UI Enhancements**
	{
		"windwp/nvim-autopairs",
		config = function() require("nvim-autopairs").setup({}) end,
	},
	{ "kyazdani42/nvim-web-devicons" },
	{
		'goolord/alpha-nvim',
		config = function()
			require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
		end
	},
	{
		'mg979/vim-visual-multi',
		branch = 'master',
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"kyazdani42/nvim-tree.lua",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function() require("daniel.tree") end,
	},
	{
		"romgrk/barbar.nvim",
		dependencies = { "lewis6991/gitsigns.nvim", "nvim-tree/nvim-web-devicons" },
	},
	{
		"folke/which-key.nvim",
		config = function() require("which-key").setup({}) end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				stages = "fade_in_slide_out", -- Animation style
			})
			vim.notify = require("notify") -- Replace default `vim.notify`
		end,
	},
	-- **Undo Tree**
	"mbbill/undotree",

	-- **Commenting**
	{ "numToStr/Comment.nvim" },

	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {}
	},
	-- **Themes**
	{ "catppuccin/nvim" },

	-- **Custom Menu**
	{ "nvzone/volt",    lazy = true },
	{ "nvzone/menu",    lazy = true },
	'MunifTanjim/nui.nvim',
	'VonHeikemen/fine-cmdline.nvim',

	-- **Debugging**
	{
		"folke/lazydev.nvim",
		config = function() require("lazydev").setup({}) end,
	},
	{ "nvim-neotest/nvim-nio" },
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = { "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui" },
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	},
	{ "mfussenegger/nvim-dap" },
})
