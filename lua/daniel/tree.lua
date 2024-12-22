-- ~/.config/nvim/lua/daniel/tree.lua
require("nvim-tree").setup({
    view = {
        width = 30,
        side = "left",
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
            },
        },
        indent_markers = {
            enable = true,
        },
        root_folder_label = false,
           },
    actions = {
        open_file = {
            quit_on_open = true,
        }
    }
})

-- Keymap to toggle the tree view and update Barbar's offset
vim.keymap.set("n", "<leader>t", function()
    -- Toggle the Nvim-Tree
    vim.cmd("NvimTreeToggle")
end, {
    desc = "Toggle file tree",
    silent = true,
    noremap = true
})
