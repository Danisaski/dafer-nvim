--@diagnostic disable: missing-fields
--@diagnostic disable: undefined-global
-- ~/.config/nvim/lua/daniel/mappings.lua

-- Map ';' to ':' and other command line tools
vim.keymap.set({ "n", "v", "x" }, ";", ":")

-- Quick navigating
-- vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Navigate down and stay centered" })
-- vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Navigate up and stay centered" })
-- vim.keymap.set({ "n", "x" }, "J", "5j")
-- vim.keymap.set({ "n", "x" }, "K", "5k")

-- Move lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move down" })

-- Keep centered when next and previous
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Insert white line without leaving normal mode
vim.keymap.set({ "n", "v", "x" }, "<leader>o", "o<Esc>k", { desc = "Insert white line below" })
vim.keymap.set({ "n", "v", "x" }, "<leader>O", "O<Esc>j", { desc = "Insert white line above" })

-- Remap 'jk' to 'Esc' in insert mode
vim.keymap.set("i", "jk", "<Esc>", { silent = true })

vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true })
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true })

-- Esc + clear highlight
vim.keymap.set({ "n", "v", "x" }, '<Esc>', function()
    if require("multicursor-nvim").hasCursors() then
        require("multicursor-nvim").clearCursors()
    end

    -- Simulate pressing <Esc>
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)

    -- Clear search highlights
    vim.cmd("noh")

    -- Close floating windows (LSP popups, Noice, etc.)
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_is_valid(win) then
            local cfg = vim.api.nvim_win_get_config(win)
            if cfg.relative ~= '' then
                vim.api.nvim_win_close(win, true)
            end
        end
    end
end, { silent = true })


vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover()
end, { silent = true })

-- Avoid Q
vim.keymap.set("n", "Q", "<nop>")

-- Substitute current cursor position word
vim.keymap.set("n", "<leader>*", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Substitute in active buffer" })

-- Floating menu for keyboard users
vim.keymap.set("n", "<leader>m", function()
    require("menu").open("default")
end, { desc = "Open context menu" })

-- Floating menu for mouse users + nvimtree users!
vim.keymap.set("n", "<RightMouse>", function()
    vim.cmd.exec '"normal! \\<RightMouse>"'

    local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
    require("menu").open(options, { mouse = true })
end, {})

-- Format Buffer
vim.keymap.set({ "n", "v", "x" }, '<leader>fm', function()
    vim.lsp.buf.format({ async = true })
end, { desc = "Format Buffer" })

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Copy Content
vim.keymap.set({ "n", "v", "x" }, "<C-c>", '"+y', { desc = "Copy Content" })

-- Paste in visual mode without copying the replaced text
vim.keymap.set("x", "p", '"_dp', { desc = "Paste without overwriting register in visual mode" })

-- Paste in visual line mode without overwriting
vim.keymap.set("x", "P", '"_dP', { desc = "Paste before without overwriting register" })

-- BarBar and Tabs
vim.keymap.set({ "n", "v", "x" }, '<leader>bb', '<Cmd>BufferPick<CR>',
    { noremap = true, silent = true, desc = "Fast buffer pick" })
vim.keymap.set({ "n", "v", "x" }, '<leader>w', '<Cmd>BufferClose<CR>',
    { noremap = true, silent = true, desc = "Close buffer" })
vim.keymap.set({ "n", "v", "x" }, '<leader>h', '<Cmd>BufferPrevious<CR>',
    { noremap = true, silent = true, desc = "Previous buffer" })
vim.keymap.set({ "n", "v", "x" }, '<leader>l', '<Cmd>BufferNext<CR>',
    { noremap = true, silent = true, desc = "Next buffer" })

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true, desc = "Move to left window" })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true, desc = "Move to right window" })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true, desc = "Move to lower window" })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true, desc = "Move to upper window" })

-- Sizing of vertical and horizontal splits
vim.keymap.set("n", "<C-w><right>", "5<C-w>>", { desc = "Increase vertical split width by 5" })
vim.keymap.set("n", "<C-w><left>", "5<C-w><", { desc = "Decrease vertical split width by 5" })

vim.keymap.set("n", "<C-w><up>", "5<C-w>+", { desc = "Increase horizontal split height by 5" })
vim.keymap.set("n", "<C-w><down>", "5<C-w>-", { desc = "Decrease horizontal split height by 5" })

-- Move to previous/next
vim.keymap.set('n', '<A-j>', '<Cmd>BufferPrevious<CR>')
vim.keymap.set('n', '<A-k>', '<Cmd>BufferNext<CR>')

-- Re-order to previous/next
vim.keymap.set('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>')
vim.keymap.set('n', '<A->>', '<Cmd>BufferMoveNext<CR>')

-- Goto buffer in position...
vim.keymap.set('n', '<A-1>', '<Cmd>BufferGoto 1<CR>')
vim.keymap.set('n', '<A-2>', '<Cmd>BufferGoto 2<CR>')
vim.keymap.set('n', '<A-3>', '<Cmd>BufferGoto 3<CR>')
vim.keymap.set('n', '<A-4>', '<Cmd>BufferGoto 4<CR>')
vim.keymap.set('n', '<A-5>', '<Cmd>BufferGoto 5<CR>')
vim.keymap.set('n', '<A-6>', '<Cmd>BufferGoto 6<CR>')
vim.keymap.set('n', '<A-7>', '<Cmd>BufferGoto 7<CR>')
vim.keymap.set('n', '<A-8>', '<Cmd>BufferGoto 8<CR>')
vim.keymap.set('n', '<A-9>', '<Cmd>BufferGoto 9<CR>')
vim.keymap.set('n', '<A-0>', '<Cmd>BufferLast<CR>')

-- Overwritten by tiny-glimmer
-- Highlight when yanking (copying) text
-- vim.api.nvim_create_autocmd('TextYankPost', {
--     desc = 'Highlight when yanking (copying) text',
--     group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
--     callback = function()
--         vim.highlight.on_yank()
--     end,
-- })

local run_script = function()
    -- Ensure the buffer is a normal file and has a valid filename
    if vim.bo.buftype ~= "" then
        vim.notify("Cannot run script: Current buffer is not a file", vim.log.levels.ERROR)
        return
    end

    local filepath = vim.fn.expand("%:p") -- Full path of the current file

    if filepath == "" then
        vim.notify("Cannot run script: Buffer has no associated file", vim.log.levels.ERROR)
        return
    end

    -- Save the current file before running
    vim.cmd("silent write")

    local filetype = vim.bo.filetype
    local filedir = vim.fn.expand("%:p:h")  -- Directory of the current file
    local filename = vim.fn.expand("%:t:r") -- File name without extension
    local is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
    local current_cwd = vim.fn.getcwd()     -- Save original working directory

    -- Helper function to run commands in a floating terminal
    local Terminal = require("toggleterm.terminal").Terminal
    local function run_in_floating_terminal(cmd, wd)
        local term = Terminal:new({
            cmd = cmd,
            dir = wd,
            direction = "float",
            hidden = true,
            close_on_exit = false,
            float_opts = {
                border = "rounded", -- You can also use "single", "double", etc.
                winblend = 10,      -- Transparency level (0-100), 10 is a mild transparency
            },
            highlights = {
                Normal = { guibg = "NONE" },   -- Transparent background for terminal window
                NormalNC = { guibg = "NONE" }, -- Transparent background for non-current windows
            },
        })
        term:toggle()
    end

    -- Handle different filetypes
    if filetype == "python" then
        local cmd_string = "python " .. filepath
        local cmd = "echo '>> " .. cmd_string .. "\n' && " .. cmd_string
        run_in_floating_terminal(cmd, filedir)
    elseif filetype == "lua" then
        local cmd_string = "lua " .. filepath
        local cmd = "echo '>> " .. cmd_string .. "\n' && " .. cmd_string
        run_in_floating_terminal(cmd, filedir)
    elseif filetype == "rust" then
        local cmd_string = "cargo run"
        local cmd = "echo '>> " .. cmd_string .. " (" .. current_cwd .. ")\n' && " .. cmd_string
        run_in_floating_terminal(cmd, current_cwd)
    elseif filetype == "zig" then
        local cmd_string = "zig build run"
        local cmd = "echo '>> " .. cmd_string .. " (" .. current_cwd .. ")\n' && " .. cmd_string
        run_in_floating_terminal(cmd, current_cwd)
    elseif filetype == "c" or filetype == "cpp" then
        -- Use gcc/g++ for Linux, cl.exe for Windows
        if is_windows then
            local output = filename .. ".exe"
            run_in_floating_terminal("cl.exe " .. filepath .. " /Fe:" .. output .. " & .\\" .. output)
        else
            local compiler = filetype == "c" and "gcc" or "g++"
            local output = filename .. "_out"
            run_in_floating_terminal(compiler .. " " .. filepath .. " -o " .. output .. " && ./" .. output)
        end
    else
        vim.notify("Unsupported filetype: " .. filetype, vim.log.levels.WARN)
        return
    end
end


-- Uppercase R runs in :term and switches to insert mode
vim.keymap.set({ "n", "v", "x" }, "<leader>r", function() run_script() end,
    { desc = "Save and run current script in terminal" })

-- Lowercase r runs using !
vim.keymap.set({ "n", "v", "x" }, "<leader>R", function() run_script() end, { desc = "Save and run current script" })
