-- ~/.config/nvim/lua/daniel/tree.lua
require("nvim-tree").setup({
    view = {
        width = 30,
        side = "left"
    },
    filters = {
        dotfiles = false
    },
    renderer = {
        highlight_git = true,
        icons = {
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true
            }
        }
    }
})

-- Function to update Barbar's offset based on Nvim-Tree's visibility
local function update_barbar_offset()
    local view = require("nvim-tree.view")
    if view.is_visible() then
        -- Set the offset to match Nvim-Tree's width when it’s open
        require("bufferline.api").set_offset(30, "File Tree")
    else
        -- Remove the offset when Nvim-Tree is closed
        require("bufferline.api").set_offset(0)
    end
end

-- Keymap to toggle the tree view and update Barbar's offset
vim.keymap.set("n", "<leader>t", function()
    -- Toggle the Nvim-Tree
    vim.cmd("NvimTreeToggle")
    -- Update Barbar's offset after toggling
    update_barbar_offset()
end, {
    silent = true,
    noremap = true
})
