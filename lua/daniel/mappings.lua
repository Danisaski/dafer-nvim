--@diagnostic disable: undefined-global
-- ~/.config/nvim/lua/daniel/mappings.lua

-- Map ';' to ':'
vim.keymap.set({ "n", "v", "x" }, ";", ":")
vim.keymap.set({ "n", "v", "x" }, "J", "5j")
vim.keymap.set({ "n", "v", "x" }, "K", "5k")
vim.keymap.set({ "n", "v", "x" }, "<leader>o", "o<ESC>k", { desc = "Insert white line below" })
vim.keymap.set({ "n", "v", "x" }, "<leader>O", "o<ESC>j", { desc = "Insert white line above" })
vim.keymap.set({ "n", "v", "x" }, '<leader>db', function()
	require('dap').continue()
end, { desc = "Start debugging session" })

vim.keymap.set({ "n", "v", "x" }, '<F9>', function()
	require('dap').toggle_breakpoint()
end, { desc = "Toggle breakpoint" })

vim.keymap.set({ "n", "v", "x" }, '<F8>', function()
	require('dapui').toggle()
end, { desc = "Toggle debugging UI" })

vim.keymap.set({ "n", "v", "x" }, '<F10>', function()
	require('dap').step_over()
end, { desc = "Step over" })

vim.keymap.set({ "n", "v", "x" }, '<F11>', function()
	require('dap').step_into()
end, { desc = "Step into" })

vim.keymap.set({ "n", "v", "x" }, '<S-F11>', function()
	require('dap').step_out()
end, { desc = "Step out" })

vim.keymap.set({ "n", "v", "x" }, '<F12>', function()
	require('dap').terminate()
end, { desc = "Stop debugging session" })

-- Keyboard users
vim.keymap.set("n", "<leader>m", function()
	require("menu").open("default")
end, { desc = "Open context menu" })

-- Keyboard users
vim.keymap.set("n", "<C-t>", function()
	require("menu").open("default")
end, { desc = "Open context menu" })

-- mouse users + nvimtree users!
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

-- Edit Config
vim.keymap.set("n", "ed", function()
	vim.cmd("edit $MYVIMRC")
end, { desc = "Edit Config" })

-- Copy Content
vim.keymap.set({ "n", "v", "x" }, "<C-c>", '"+y', { desc = "Copy Content" })

-- Delete Content
vim.keymap.set({ "v", "x" }, "dc", '"_d', { desc = "Delete Content" })

-- Paste in visual mode without copying the replaced text
vim.keymap.set("x", "p", '"_dp', { desc = "Paste without overwriting register in visual mode" })

-- Paste in visual line mode without overwriting
vim.keymap.set("x", "P", '"_dP', { desc = "Paste before without overwriting register" })


-- Remap 'jk' to 'Esc' in insert mode
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = "Toggle undo tree" })

-- Keybinding to trigger Telescope
vim.keymap.set({ "n", "v", "x" }, "<leader>ff", require("telescope.builtin").find_files, { desc = "Find Files" })
vim.keymap.set({ "n", "v", "x" }, "<leader>fg", require("telescope.builtin").live_grep, { desc = "Live Grep" })

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
