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
