-- ~/.config/nvim/lua/daniel/alpha.lua
local alpha = require('alpha')
local startify = require('alpha.themes.startify')

-- Define ASCII art as a multi-line string
local ascii_art = [[
    _   __                _
   / | / /__  ____ _   __(_)___ ___
  /  |/ / _ \/ __ \ | / / / __ `__ \
 / /|  /  __/ /_/ / |/ / / / / / / /
/_/ |_/\___/\____/|___/_/_/ /_/ /_/
]]

-- Convert the string into a list of lines
startify.section.header.val = vim.split(ascii_art, "\n", { trimempty = true })

-- Setup Alpha with Startify theme
alpha.setup(startify.config)
