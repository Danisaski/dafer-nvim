-- ~/.config/nvim/lua/user/settings.lua

-- Automatically save the file when leaving insert mode
vim.cmd("autocmd InsertLeave * write")

vim.o.cursorlineopt = 'both'

-- Enable relative line numbers
vim.wo.relativenumber = true
vim.wo.number = true -- Ensure absolute line number for the current line
