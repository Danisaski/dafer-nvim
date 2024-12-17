---@diagnostic disable: undefined-global
-- ~/.config/nvim/lua/daniel/plugins.lua
-- Set up lazy.nvim as the plugin manager
require("lazy").setup({
    -- **Plugin Manager**
    "folke/lazy.nvim",

    -- **LSP and Tooling Management**
    {
        'neovim/nvim-lspconfig',
        dependencies = { 'saghen/blink.cmp',
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer" },
    },
    {
        'saghen/blink.cmp',
        lazy = false, -- lazy loading handled internally
        dependencies = 'rafamadriz/friendly-snippets',
        version = 'v0.*',

        -- Load the configuration from the external file
        opts = require("daniel.blink_cmp"),
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
        config = true,
        opts = {
            map_bs = false,
        },
    },
    { "kyazdani42/nvim-web-devicons" },
    {
        'goolord/alpha-nvim',
        dependencies = { 'echasnovski/mini.icons' },
        config = function()
            require 'alpha'.setup(require 'alpha.themes.startify'.config)
        end
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
            "stevearc/dressing.nvim",
        }
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
        dependencies = { "lewis6991/gitsigns.nvim", "nvim-tree/nvim-web-devicons", 'echasnovski/mini.nvim' },
    },
    {
        "folke/which-key.nvim",
        config = function() require("which-key").setup({}) end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons" },
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
    {
        "catppuccin/nvim",
        priority = 1000,
        init = function()
            vim.cmd("colorscheme catppuccin")
        end
    },

    -- **Custom Menu**
    { "nvzone/volt", lazy = true },
    { "nvzone/menu", lazy = true },
    'MunifTanjim/nui.nvim',

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
