-- ~/.config/nvim/lua/daniel/alpha.lua
local alpha = require('alpha')
local startify = require('alpha.themes.startify')

-- Define ASCII art as a multi-line string
local ascii_art = [[
   ____      .---.      _______      ____
 .'  __ `.   | ,_|     \  ____  \  .'  __ `.
/   '  \  \,-./  )     | |    \ | /   '  \  \
|___|  /  |\  '_ '`)   | |____/ / |___|  /  |
   _.-`   | > (_)  )   |   _ _ '.    _.-`   |
.'   _    |(  .  .-'   |  ( ' )  \.'   _    |
|  _( )_  | `-'`-'|___ | (_{;}_) ||  _( )_  |
\ (_ o _) /  |        \|  (_,_)  /\ (_ o _) /
 '.(_,_).'   `--------`/_______.'  '.(_,_).'

]]

-- Convert the string into a list of lines
startify.section.header.val = vim.split(ascii_art, "\n", { trimempty = true })

-- Setup Alpha with Startify theme
alpha.setup(startify.config)
