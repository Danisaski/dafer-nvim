-- ~/.config/nvim/init.lua
vim.g.mapleader = " "

-- Prepend lazy.nvim to the runtime path
vim.opt.rtp:prepend("C:/Users/dafer/AppData/Local/nvim/lazy/lazy.nvim")

-- Load the plugins configuration
require("daniel.plugins")

-- Load other configurations
require("daniel.mappings")
require("daniel.mason")
require("daniel.settings")
require("daniel.statusbar")
require("daniel.telescope")
require("daniel.theme")
require("daniel.tree")
require("daniel.gitsigns")
require('daniel.treesitter')
require('daniel.undotree')
require('daniel.lspconfig')
require('daniel.formatters')
