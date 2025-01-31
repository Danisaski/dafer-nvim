local diag_winid = nil

local function is_any_floating_window_open()
    -- Get all open windows and check if any of them is a floating window
    for _, winid in ipairs(vim.api.nvim_list_wins()) do
        local win_config = vim.api.nvim_win_get_config(winid)
        if win_config.relative ~= "" then
            return true -- A floating window is open
        end
    end
    return false -- No floating window is open
end

local function show_line_diagnostics()
    -- Close existing diagnostic window if it exists
    if diag_winid and vim.api.nvim_win_is_valid(diag_winid) then
        vim.api.nvim_win_close(diag_winid, false)
        diag_winid = nil
        return
    end

    -- Only show diagnostics if no other floating window is open
    if not is_any_floating_window_open() then
        diag_winid = vim.diagnostic.open_float(nil, {
            focusable = false,
            scope = "line",
            border = "rounded",
        })
    end
end

local diagnostic_group = vim.api.nvim_create_augroup('DiagnosticFloat', { clear = true })

vim.api.nvim_create_autocmd("CursorHold", {
    group = diagnostic_group,
    callback = show_line_diagnostics,
    desc = "Toggle line diagnostics in a floating window",
})

vim.api.nvim_create_autocmd({ "WinClosed", "BufWinEnter", "WinNew" }, {
    group = diagnostic_group,
    callback = function()
        if diag_winid and vim.api.nvim_win_is_valid(diag_winid) then
            vim.api.nvim_win_close(diag_winid, false)
            diag_winid = nil
        end
    end,
    desc = "Close diagnostic window when any other popup window appears",
})

