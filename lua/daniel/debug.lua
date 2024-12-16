local dap = require("dap")
local dapui = require("dapui")
require("dap-python").setup("python")
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end
-- Update UI for dap-repl outputs
dap.listeners.after.event_output["dapui_update"] = function()
	-- Trigger a manual redraw of the UI
	dapui.open({}) -- Opens without changing state if already open
end


-- Define the sign for breakpoints
vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })

-- Optionally, set up additional signs for different types of breakpoints
vim.fn.sign_define("DapBreakpointRejected", { text = "×", texthl = "DapBreakpointRejected", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "" })


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
