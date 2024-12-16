--@diagnostic disable: undefined-global
-- ~/.config/nvim/lua/daniel/mappings.lua

-- Map ';' to ':' and other command line tools
vim.keymap.set({ "n", "v", "x" }, ";", "<cmd>FineCmdline<CR>", { silent = true })
vim.keymap.set({ "n", "v", "x" }, ":", "<cmd>FineCmdline<CR>", { silent = true })

-- Quick navigating
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Navigate down and stay centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Navigate up and stay centered" })
vim.keymap.set({ "n", "x" }, "J", "5j")
vim.keymap.set({ "n", "x" }, "K", "5k")

-- Move lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move down" })

-- Keep centered when next and previous
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Insert white line without leaving normal mode
vim.keymap.set({ "n", "v", "x" }, "<leader>o", "o<ESC>k", { desc = "Insert white line below" })
vim.keymap.set({ "n", "v", "x" }, "<leader>O", "O<ESC>j", { desc = "Insert white line above" })

-- Remap 'jk' to 'Esc' in insert mode
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })

-- Avoid Q
vim.keymap.set("n", "Q", "<nop>")

-- Substitute current cursor position word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Substitute in active buffer" })

-- Search in buffer
vim.keymap.set("n", "<C-f>", "/", { noremap = true })

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

-- Code Actions
vim.keymap.set({ "n", "v" }, '<leader>ca', function()
    vim.lsp.buf.code_action()
end, { desc = "Code Actions" })

-- Copy Content
vim.keymap.set({ "n", "v", "x" }, "<C-c>", '"+y', { desc = "Copy Content" })

-- Delete Content
vim.keymap.set({ "v", "x" }, "dc", '"_d', { desc = "Delete Content" })

-- Paste in visual mode without copying the replaced text
vim.keymap.set("x", "p", '"_dp', { desc = "Paste without overwriting register in visual mode" })

-- Paste in visual line mode without overwriting
vim.keymap.set("x", "P", '"_dP', { desc = "Paste before without overwriting register" })

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = "Toggle undo tree" })

-- Keybinding to trigger Telescope
vim.keymap.set({ "n", "v", "x" }, "<leader>ff", require("telescope.builtin").find_files, { desc = "Find Files" })
vim.keymap.set({ "n", "v", "x" }, "<leader>fg", require("telescope.builtin").live_grep, { desc = "Live Grep" })

-- Recently opened files
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope oldfiles<cr>",
    { silent = true, noremap = true, desc = "Recently opened files" })

-- Jump to bookmarks
vim.keymap.set("n", "<leader>bm", "<cmd>Telescope marks<cr>",
    { silent = true, noremap = true, desc = "Jump to bookmarks" })

-- BarBar and Tabs
vim.keymap.set({ "n", "v", "x" }, '<leader>bb', '<Cmd>BufferPick<CR>',
    { noremap = true, silent = true, desc = "Fast buffer pick" })
vim.keymap.set({ "n", "v", "x" }, '<leader>w', '<Cmd>BufferClose<CR>',
    { noremap = true, silent = true, desc = "Close buffer" })
vim.keymap.set({ "n", "v", "x" }, '<leader>j', '<Cmd>BufferPrevious<CR>',
    { noremap = true, silent = true, desc = "Previous buffer" })
vim.keymap.set({ "n", "v", "x" }, '<leader>k', '<Cmd>BufferNext<CR>',
    { noremap = true, silent = true, desc = "Next buffer" })

vim.keymap.set('n', '<leader>h', '<C-w>h', { noremap = true, silent = true, desc = "Move to left window" })
vim.keymap.set('n', '<leader>l', '<C-w>l', { noremap = true, silent = true, desc = "Move to right window" })

-- Keymap to toggle the tree view and update Barbar's offset
vim.keymap.set("n", "<leader>t", function()
    -- Toggle the Nvim-Tree
    vim.cmd("NvimTreeToggle")
end, {
    desc = "Toggle file tree",
    silent = true,
    noremap = true
})

local run_script = function(mode)
    -- Save the current file before running
    vim.cmd("silent write")
    -- Set CWD to the directory of the current file
    vim.cmd("cd %:p:h")
    local filetype = vim.bo.filetype

    if filetype == "python" then
        if mode == "term" then
            vim.cmd(":term python %")
        else
            vim.cmd("!python %")
        end
    elseif filetype == "lua" then
        if mode == "term" then
            vim.cmd(":term lua %")
        else
            vim.cmd("!lua %")
        end
    elseif filetype == "rust" then
        if mode == "term" then
            vim.cmd(":term cargo run")
        else
            vim.cmd("!cargo run")
        end
    else
        print("Unsupported filetype")
    end

    -- If running in terminal mode, switch to insert mode
    if mode == "term" then
        vim.cmd("startinsert")
    end
end

-- Uppercase R runs in :term and switches to insert mode
vim.keymap.set({ "n", "v", "x" }, "<leader>r", function() run_script("term") end,
    { desc = "Save and run current script in terminal" })

-- Lowercase r runs using !
vim.keymap.set({ "n", "v", "x" }, "<leader>R", function() run_script() end, { desc = "Save and run current script" })
