-- ~/.config/nvim/lua/daniel/settings.lua

vim.g.have_nerd_font = true

vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'

vim.opt.nu = true
vim.opt.relativenumber = false
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
vim.opt.ttimeoutlen = 10

vim.opt.colorcolumn = "80"

-- Auto-save when leaving insert mode, only if it's a valid file type
vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
        -- Ensure buffer is modified, is a normal file, and has a filetype
        if vim.bo.modified and vim.bo.buftype == "" and vim.fn.expand("%:p") ~= "" and vim.bo.modifiable and not vim.bo.readonly then
            local ft = vim.bo.filetype
            local allowed_filetypes = { "python", "rust", "markdown", "go", "c", "cpp", "vim", "lua" } -- Customize as needed

            if vim.tbl_contains(allowed_filetypes, ft) then
                vim.cmd("silent write") -- Auto-save
            end
        end
    end,
})

-- Auto-save on InsertLeave if the filetype can be saved
vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*", -- You can adjust this to specific filetypes, e.g., {"python", "lua"}
    callback = function()
        local ft = vim.bo.filetype
        -- Add your list of valid filetypes here (adjust as needed)
        local valid_filetypes = { "python", "lua", "go", "cpp", "rust", "json", "c" }
        if vim.fn.index(valid_filetypes, ft) ~= -1 and vim.fn.bufname() ~= "" then
            vim.cmd("silent write")
        end
    end,
})

-- Autoformat on manual save if LSP is attached and can format
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*", -- You can adjust this to specific filetypes if needed
    callback = function()
        -- Check if an LSP server is attached and can format
        local clients = vim.lsp.get_clients()
        if next(clients) then
            for _, client in pairs(clients) do
                if client.server_capabilities.documentFormattingProvider then
                    -- Trigger LSP formatting before saving
                    vim.lsp.buf.format({ async = false })
                    break
                end
            end
        end
    end,
})
