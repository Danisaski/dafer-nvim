---@diagnostic disable: undefined-global

local run_script = function(rust_mode, zig_mode)
    local current_cwd = vim.fn.getcwd()
    local filepath = vim.fn.expand("%:p") -- Full path
    local filedir = vim.fn.expand("%:p:h")
    local filetype = vim.bo.filetype

    local is_rust_project = vim.fn.filereadable(current_cwd .. "/Cargo.toml") == 1
    local is_zig_project = vim.fn.filereadable(current_cwd .. "/build.zig") == 1
    local is_c_project = vim.fn.filereadable(current_cwd .. "/Makefile") == 1

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

    -- Get first target from Makefile (excluding .PHONY)
    local function get_makefile_target()
        local makefile_path = current_cwd .. "/Makefile"
        local lines = vim.fn.readfile(makefile_path)
        for _, line in ipairs(lines) do
            local target = line:match("^([%w%._-]+):")
            if target and target ~= ".PHONY" then
                return target
            end
        end
        return nil
    end

    local ran = false -- Track if we ran anything

    -- Attempt to run the file directly if it's a known code file (excluding C/C++)
    if filepath ~= "" and vim.bo.buftype == "" then
        vim.cmd("silent write") -- Save file

        local cmd_string, cmd
        if filetype == "python" then
            cmd_string = "python " .. filepath
        elseif filetype == "lua" then
            cmd_string = "lua " .. filepath
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

    -- Fallback to project-level runners
    if not ran then
        if is_rust_project then
            local cmd = "echo '>> cargo " .. rust_mode .. " (" .. current_cwd .. ")\\n' && cargo run"
            run_in_floating_terminal(cmd, current_cwd)
            ran = true
        elseif is_zig_project then
            local cmd = "echo '>> zig " .. zig_mode .. " (" .. current_cwd .. ")\\n' && zig build run"
            run_in_floating_terminal(cmd, current_cwd)
            ran = true
        elseif is_c_project then
            local target = get_makefile_target()
            local cmd
            if target then
                cmd = "echo '>> make " .. target .. " (" .. current_cwd .. ")\\n' && make " .. target
            else
                cmd = "echo '>> make (" .. current_cwd .. ")\\n' && make"
            end
            run_in_floating_terminal(cmd, current_cwd)
            ran = true
        end
    end

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
