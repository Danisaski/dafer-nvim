-- ~/.config/nvim/init.lua

-- Determine the proper path based on OS
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if vim.fn.has('win32') == 1 then
    -- Windows path (using backslashes)
    lazypath = vim.fn.stdpath("data") .. "\\lazy\\lazy.nvim"
end

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

-- Disable built-in plugins early for faster startup
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1

-- Set leaders early
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load core settings first (before plugins)
require("daniel.settings")

-- Load plugins configuration
require("daniel.plugins")

-- Load other configurations after plugins
require('daniel.diagnostics')
require('daniel.lspconfig')
require('daniel.run')
require('daniel.debug')
require("daniel.mappings")
