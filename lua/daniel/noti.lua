local notify = require("notify")

notify.setup({
    stages = "fade_in_slide_out",             -- Animation style
    timeout = 3000,
    render = "compact",
})

-- vim.notify = require("notify")             -- Replace default `vim.notify`

-- Override the default vim.notify function to use nvim-notify
vim.notify = function(msg, log_level, opts)
    -- Default notification level, if not provided
    log_level = log_level or vim.log.levels.INFO

    -- Use nvim-notify for logging
    notify(msg, log_level, opts)

    -- If it's an error (e.g., E486), make sure it's routed to the notification pop-up
    if log_level == vim.log.levels.ERROR then
        -- Additional custom handling for errors, if needed
    end
end


-- Ensure nvim-notify is used for all messages
vim.notify = notify
