-- ~/.config/nvim/lua/daniel/plugins.lua
-- Set up lazy.nvim as the plugin manager
require("lazy").setup({ -- Plugin Manager
	"folke/lazy.nvim", -- **LSP and Tooling Management**
	{
		"VonHeikemen/lsp-zero.nvim",
		dependencies = { { "neovim/nvim-lspconfig" }, -- Native LSP configuration
			{ "williamboman/mason.nvim" }, -- LSP server manager
			{ "williamboman/mason-lspconfig.nvim" }, -- Integrates Mason with lspconfig
			{
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				dependencies = { "williamboman/mason.nvim" } -- Ensures mason.nvim is loaded first
			}, {
			"hrsh7th/nvim-cmp",      -- Completion engine
			config = function()
				require("daniel.cmp") -- Custom completion configuration
			end
		}, { "hrsh7th/cmp-nvim-lsp" },   -- LSP source for nvim-cmp
			{ "hrsh7th/cmp-buffer" }, -- Buffer source for nvim-cmp
			{ "hrsh7th/cmp-path" },  -- Path source for nvim-cmp
			{ "onsails/lspkind-nvim" } -- Icons and labels for completion menu
		}
	},                                       -- **Treesitter**
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate"
	},          -- **Undotree**
	'mbbill/undotree', -- **Auto Pairs**
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({}) -- Basic auto-pairs setup
		end
	},                             -- **File Icons**
	"kyazdani42/nvim-web-devicons", -- File icons for plugins
	-- **Fuzzy Finder**
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" } -- Telescope dependencies
	},                                           -- **File Explorer**
	{
		"kyazdani42/nvim-tree.lua",          -- File tree explorer
		dependencies = { "kyazdani42/nvim-web-devicons" }, -- Optional: File icons
		config = function()
			require("daniel.tree")       -- Custom tree configuration
		end
	},                                           -- **Buffer Line**
	{
		"romgrk/barbar.nvim",
		dependencies = { "lewis6991/gitsigns.nvim", -- Optional: Git integration
			"nvim-tree/nvim-web-devicons" -- Optional: File icons
		}
	},                                    -- **Git Integration**
	"lewis6991/gitsigns.nvim",            -- Shows git changes in sign column
	'numToStr/Comment.nvim',
	-- **Keybinding Helper**
	{
		"folke/which-key.nvim", -- Visual keybinding prompt
		config = function()
			require("which-key").setup({})
		end
	},                                          -- **Status Line**
	{
		"nvim-lualine/lualine.nvim",        -- Status line plugin
		dependencies = { "kyazdani42/nvim-web-devicons" } -- Optional: Icons
	},                                          -- **Themes**
	"catppuccin/nvim"                           -- Catppuccin theme
	-- Additional Plugins can be added below as needed
})
