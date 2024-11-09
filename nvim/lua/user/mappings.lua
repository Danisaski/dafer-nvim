-- ~/.config/nvim/lua/user/mappings.lua

-- Map ';' to ':'
vim.keymap.set("n", ";", ":")

-- Remap 'jk' to 'Esc' in insert mode
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })

-- Map Ctrl+Alt+N to save and then run the current script in multiple modes
local run_script = function()
  -- Save the current file before running
  vim.cmd("silent write")

  local filetype = vim.bo.filetype

  if filetype == "python" then
    vim.cmd("!python3 %")
  elseif filetype == "lua" then
    vim.cmd("!lua %")
  elseif filetype == "rust" then
    vim.cmd("!cargo run")
  else
    print("Unsupported filetype")
  end
end

-- In Insert mode, simulate the Ctrl+Alt+N keypress to run the function directly
vim.keymap.set("i", "<C-A-n>", function()
  -- Run the script without leaving Insert mode
  run_script()
  -- Simulate pressing Esc to remain in Insert mode
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
end, { desc = "Save and run current script" })

-- Apply the mapping in Normal mode (n), Insert mode (i), Visual mode (v), and other modes
vim.keymap.set("n", "<C-A-n>", run_script, { desc = "Save and run current script" })
vim.keymap.set("v", "<C-A-n>", run_script, { desc = "Save and run current script" })
vim.keymap.set("x", "<C-A-n>", run_script, { desc = "Save and run current script" })
vim.keymap.set("c", "<C-A-n>", run_script, { desc = "Save and run current script" })

