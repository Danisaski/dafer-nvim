---@diagnostic disable: undefined-global
--@diagnostic disable: missing-fields
--@diagnostic disable: undefined-global
-- ~/.config/nvim/lua/daniel/mappings.lua

-- Map ';' to ':' and other command line tools
vim.keymap.set({ "n", "v", "x" }, ";", ":")

-- Quick navigating
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Navigate down and stay centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Navigate up and stay centered" })

-- Move lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true, noremap = true, desc = "Move down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true, noremap = true, desc = "Move down" })

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

-- Navigate buffers
vim.keymap.set("n", "<M-j>", ":bprevious<CR>",
    { silent = true, noremap = true, desc = "Previous buffer" })
vim.keymap.set("n", "<M-k>", ":bnext<CR>",
    { silent = true, noremap = true, desc = "Next buffer" })

-- Close buffer
vim.keymap.set({ "n", "v", "x" }, "<leader>bd", ":bd<CR>",
    { silent = true, noremap = true, desc = "Close current buffer" })

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

-- Avoid Q
vim.keymap.set("n", "Q", "<nop>")

-- Substitute current cursor position word
vim.keymap.set("n", "<leader>*", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Substitute in active buffer" })

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

local run_script = function(rust_mode, zig_mode)
    local current_cwd = vim.fn.getcwd()
    local filepath = vim.fn.expand("%:p") -- Full path
    local filedir = vim.fn.expand("%:p:h")
    local filename = vim.fn.expand("%:t:r")
    local filetype = vim.bo.filetype
    local is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1

    local is_rust_project = vim.fn.filereadable(current_cwd .. "/Cargo.toml") == 1
    local is_zig_project = vim.fn.filereadable(current_cwd .. "/build.zig") == 1

    -- Floating terminal helper
    local Terminal = require("toggleterm.terminal").Terminal
    local function run_in_floating_terminal(cmd, wd)
        local term = Terminal:new({
            cmd = cmd,
            dir = wd,
            direction = "float",
            hidden = true,
            close_on_exit = false,
            float_opts = {
                border = "rounded",
                winblend = 10,
            },
            highlights = {
                Normal = { guibg = "NONE" },
                NormalNC = { guibg = "NONE" },
            },
        })
        term:toggle()
    end

    local ran = false -- Track if we ran anything

    -- Attempt to run the file directly if it's a known code file
    if filepath ~= "" and vim.bo.buftype == "" then
        -- Save file
        vim.cmd("silent write")

        local cmd_string, cmd
        if filetype == "python" then
            cmd_string = "python " .. filepath
        elseif filetype == "lua" then
            cmd_string = "lua " .. filepath
        elseif filetype == "c" or filetype == "cpp" then
            if is_windows then
                local output = filename .. ".exe"
                cmd_string = "cl.exe " .. filepath .. " /Fe:" .. output .. " & .\\" .. output
            else
                local compiler = filetype == "c" and "gcc" or "g++"
                local output = filename .. "_out"
                cmd_string = compiler .. " " .. filepath .. " -o " .. output .. " && ./" .. output
            end
        elseif filetype == "javascript" then
            cmd_string = "node " .. filepath
        elseif filetype == "typescript" then
            cmd_string = "ts-node " .. filepath
        end

        if cmd_string then
            cmd = "echo '>> " .. cmd_string .. "\n' && " .. cmd_string
            run_in_floating_terminal(cmd, filedir)
            ran = true
        end
    end

    -- Fallback to Rust/Zig project run if filetype not supported or file invalid
    if not ran then
        if is_rust_project then
            local cmd = "echo '>> cargo " .. rust_mode .. " (" .. current_cwd .. ")\\n' && cargo run"
            run_in_floating_terminal(cmd, current_cwd)
            ran = true
        elseif is_zig_project then
            local cmd = "echo '>> zig " .. zig_mode .. " (" .. current_cwd .. ")\\n' && zig build run"
            run_in_floating_terminal(cmd, current_cwd)
            ran = true
        end
    end

    -- If we still haven't run anything, show error
    if not ran then
        vim.notify("Cannot run script: unsupported filetype and no known project type", vim.log.levels.ERROR)
    end
end

-- Uppercase R runs in :term and switches to insert mode
vim.keymap.set({ "n", "v", "x" }, "<leader>r", function() run_script('run', 'build run') end,
    { desc = "Save and run current script in terminal." })

-- Lowercase r runs using !
vim.keymap.set({ "n", "v", "x" }, "<leader>R", function() run_script('check', 'build test') end,
    { desc = "Save and check current script in terminal." })
