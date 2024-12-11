--@diagnostic disable: undefined-global
-- ~/.config/nvim/lua/daniel/mappings.lua

-- Map ';' to ':'
vim.keymap.set({ "n", "v", "x" }, ";", ":")
vim.keymap.set({ "n", "v", "x" }, "J", "5j")
vim.keymap.set({ "n", "v", "x" }, "K", "5k")
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

vim.keymap.set({ "n", "v", "x" }, '<ESC>', function()
	require('dap').terminate()
end, { desc = "Stop debugging session" })



-- Remap 'jk' to 'Esc' in insert mode
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = "Toggle undo tree" })


-- Function to update Barbar's offset based on Nvim-Tree's visibility
local function update_barbar_offset()
	local view = require("nvim-tree.view")
	if view.is_visible() then
		-- Set the offset to match Nvim-Tree's width when it’s open
		require("bufferline.api").set_offset(30, "File Tree")
	else
		-- Remove the offset when Nvim-Tree is closed
		require("bufferline.api").set_offset(0)
	end
end

-- Keymap to toggle the tree view and update Barbar's offset
vim.keymap.set("n", "<leader>t", function()
	-- Toggle the Nvim-Tree
	vim.cmd("NvimTreeToggle")
	-- Update Barbar's offset after toggling
	update_barbar_offset()
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
vim.keymap.set({ "n", "v", "x" }, "<leader>R", function() run_script("term") end,
	{ desc = "Save and run current script in terminal" })

-- Lowercase r runs using !
vim.keymap.set({ "n", "v", "x" }, "<leader>r", function() run_script() end, { desc = "Save and run current script" })
