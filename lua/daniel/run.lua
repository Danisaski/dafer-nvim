---@diagnostic disable: undefined-global

local run_script = function(rust_mode, zig_mode)
    local current_cwd = vim.fn.getcwd()
    local filepath = vim.fn.expand("%:p")   -- Full path
    local filedir = vim.fn.expand("%:p:h")
    local filename = vim.fn.expand("%:t:r") -- Filename without extension
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

    -- Compile single C/C++ file with clang/gcc
    local function compile_single_c_file()
        local compiler = filetype == "c" and "clang" or "clang++"
        local output = filename .. "_out"
        local cmd_string = compiler .. " " .. filepath .. " -o " .. output .. " && ./" .. output

        -- Save before compiling
        vim.cmd("silent write")

        local full_cmd = "echo '>> " .. cmd_string .. "\\n' && " .. cmd_string
        run_in_floating_terminal(full_cmd, filedir)
    end

    -- Prompt user for C/C++ compilation choice
    local function c_compile_choice()
        vim.ui.select({ "Project (Makefile)", "Single file" }, {
            prompt = "Compile C/C++ project or single file?",
            format_item = function(item) return item end,
        }, function(choice)
            if choice == "Project (Makefile)" then
                -- Use existing Makefile logic
                local target = get_makefile_target()
                local cmd
                if target then
                    cmd = "echo '>> make " .. target .. " (" .. current_cwd .. ")\\n' && make " .. target
                else
                    cmd = "echo '>> make (" .. current_cwd .. ")\\n' && make"
                end
                run_in_floating_terminal(cmd, current_cwd)
            elseif choice == "Single file" then
                compile_single_c_file()
            else
                vim.notify("Cancelled compilation.", vim.log.levels.INFO)
            end
        end)
    end

    local ran = false -- Track if we ran anything

    -- Handle C/C++ files with prompt if Makefile exists
    if (filetype == "c" or filetype == "cpp") and filepath ~= "" and vim.bo.buftype == "" then
        vim.cmd("silent write") -- Save file

        if is_c_project then
            -- Prompt user choice async
            c_compile_choice()
            ran = true
        else
            -- No Makefile, just compile single file
            compile_single_c_file()
            ran = true
        end
    end

    -- Attempt to run the file directly if it's a known code file (excluding C/C++)
    if not ran and filepath ~= "" and vim.bo.buftype == "" then
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

    -- Fallback to project-level runners for Rust, Zig, Makefile (if no previous run)
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
