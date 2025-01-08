-- ~/.config/nvim/lua/daniel/settings.lua

vim.g.have_nerd_font = true

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
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"

vim.opt.termguicolors = true

vim.opt.scrolloff = 10

vim.opt.updatetime = 50
vim.opt.timeoutlen = 300

vim.opt.colorcolumn = "80"


-- Automatically save the file when leaving insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    callback = function()
        if vim.bo.buftype == "" then
            -- Save using buf_write to trigger proper LSP events
            local ok = pcall(vim.api.nvim_buf_call, 0, function()
                vim.cmd.update({ mods = { silent = true } })
            end)
        end
    end,
    desc = "Silent save on InsertLeave"
})
