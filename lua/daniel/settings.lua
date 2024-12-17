-- ~/.config/nvim/lua/daniel/settings.lua

-- Automatically save the file when leaving insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    callback = function()
        -- Check the buffer type
        if vim.bo.buftype == "" then
            vim.cmd("silent! write") -- Write only if it's a normal buffer
        end
    end,
})

vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#FF0000", bold = true })         -- Red dot
vim.api.nvim_set_hl(0, "DapBreakpointRejected", { fg = "#FFA500", bold = true }) -- Orange for rejected breakpoints
vim.api.nvim_set_hl(0, "DapStopped", { fg = "#00FF00", bold = true })            -- Green for current line
vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#003300" })                     -- Background for stopped line
