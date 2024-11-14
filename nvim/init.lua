-- ~/.config/nvim/init.lua

vim.g.mapleader = " "

-- Prepend lazy.nvim to the runtime path
vim.opt.rtp:prepend("C:/Users/dafer/AppData/Local/nvim/lazy/lazy.nvim")

-- Load the plugins configuration
require("user.plugins")

-- Load other configurations
require("user.cmp")
require("user.formatters")
require("user.diagnostics")
require("user.lspconfig")
require("user.mappings")
require("user.mason")
require("user.settings")
require("user.statusbar")
require("user.telescope")
require("user.theme")
require("user.tree")
require("user.gitsigns")
