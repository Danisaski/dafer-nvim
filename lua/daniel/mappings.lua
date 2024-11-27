--@diagnostic disable: undefined-global
-- ~/.config/nvim/lua/daniel/mappings.lua

-- Map ';' to ':'
vim.keymap.set("n", ";", ":")
vim.keymap.set("n", "J", "5j")
vim.keymap.set("n", "K", "5k")

-- Remap 'jk' to 'Esc' in insert mode
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

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
end


-- Uppercase R runs in :term
vim.keymap.set("n", "<leader>R", function() run_script("term") end, { desc = "Save and run current script in terminal" })
vim.keymap.set("v", "<leader>R", function() run_script("term") end, { desc = "Save and run current script in terminal" })
vim.keymap.set("x", "<leader>R", function() run_script("term") end, { desc = "Save and run current script in terminal" })

-- Lowercase r runs using !
vim.keymap.set("n", "<leader>r", function() run_script() end, { desc = "Save and run current script" })
vim.keymap.set("v", "<leader>r", function() run_script() end, { desc = "Save and run current script" })
vim.keymap.set("x", "<leader>r", function() run_script() end, { desc = "Save and run current script" })
