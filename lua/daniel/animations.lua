local M = {}

local animate = require("mini.animate")

M.setup = function()
    animate.setup({
        cursor = {
            enable = true,
            timing = animate.gen_timing.linear({ easing = "in-out", duration = 200, unit = "total" }),
            path = animate.gen_path.line({ max_output_steps = 300 }),
        },
        scroll = {
            enable = false,
            timing = animate.gen_timing.linear({ easing = "in-out", duration = 200, unit = "total" }),
            subscroll = animate.gen_subscroll.equal({ max_output_steps = 100 }),
        },
        resize = {
            enable = false,
            timing = animate.gen_timing.linear({ easing = "in-out", duration = 180, unit = "total" }),
        },
        open = {
            enable = false,
            timing = animate.gen_timing.cubic({ easing = "in-out", duration = 400, unit = "total" }),
            winconfig = animate.gen_winconfig.wipe({ direction = "from_center" }),
            winblend = animate.gen_winblend.linear({ from = 40, to = 80 }),
        },
        close = {
            enable = false,
            timing = animate.gen_timing.cubic({ easing = "in-out", duration = 400, unit = "total" }),
            winconfig = animate.gen_winconfig.wipe({ direction = "to_center" }), -- Shrinks to an edge
            winblend = animate.gen_winblend.linear({ from = 80, to = 40 }),
        },
    })
end

return M
