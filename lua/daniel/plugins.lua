---@diagnostic disable: undefined-global, missing-fields
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
        config = function()
            require("daniel.mason")
        end
    },
    {
        'saghen/blink.cmp',
        dependencies = 'rafamadriz/friendly-snippets',
        version = '*',

        -- Load the configuration from the external file
        opts = require("daniel.blink_cmp"),
    },
    {
        "kdheepak/lazygit.nvim",
        lazy = true,
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        keys = {
            { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
        }
    },
    -- **Treesitter**
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("daniel.treesitter")
        end
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
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("ibl").setup({
                indent = {
                    char = "▏", -- Use a thin line character
                },
                scope = { enabled = false }
            })
        end
    },
    {
        "rachartier/tiny-glimmer.nvim",
        event = "VeryLazy",
        config = function()
            require("tiny-glimmer").setup({
                disable_warnings = false,
                overwrite = {
                    yank = { enabled = true },
                    search = { enabled = true },
                    paste = { enabled = true },
                    undo = { enabled = true },
                    redo = { enabled = true }
                }
            })
        end
    },
    {
        'petertriho/nvim-scrollbar',
        config = function()
            require("scrollbar").setup({
                handle = {
                    blend = 20,
                    color = "#504945",
                },
                handlers = { gitsigns = true }
            })
        end
    },
    {
        'goolord/alpha-nvim',
        dependencies = { 'echasnovski/mini.icons' },
        config = function()
            require('alpha').setup(require('alpha.themes.startify').config)
        end
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            {
                "rcarriga/nvim-notify",
                opts = {
                    top_down = false,
                },
            },
            "stevearc/dressing.nvim",
        },
        config = function()
            require("daniel.noice")
        end
    },
    {
        "jake-stewart/multicursor.nvim",
        branch = '1.0',
        config = function() require("daniel.multicursor").setup() end,
    },
    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("daniel.fzf_lua")
        end
    },
    {
        "kyazdani42/nvim-tree.lua",
        dependencies = { "kyazdani42/nvim-web-devicons" },
        config = function() require("daniel.tree") end,
    },
    {
        "sphamba/smear-cursor.nvim",
        opts = {},
    },
    {
        "romgrk/barbar.nvim",
        dependencies = { "lewis6991/gitsigns.nvim", "nvim-tree/nvim-web-devicons" },
    },
    {
        "folke/which-key.nvim",
        config = function() require("which-key").setup({ preset = 'modern' }) end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons" },
        config = function()
            require("daniel.statusbar")
        end
    },
    -- **Undo Tree**
    {
        "mbbill/undotree",
        config = function()
            require("daniel.undotree")
        end
    },

    -- **Commenting**
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {}
    },
    -- **Themes**
    {
        -- "catppuccin/nvim",
        -- "rebelot/kanagawa.nvim",
        "sainnhe/gruvbox-material",
        lazy = false,
        priority = 1000,
        config = function()
            require('daniel.theme').setup()
        end,
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
