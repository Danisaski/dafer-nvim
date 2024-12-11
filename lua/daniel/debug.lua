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
