require("lualine").setup({
    options = {
        theme = "catppuccin", -- Choose a theme that fits your style
        icons_enabled = true,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics", "lsp_progress" }, -- Add LSP progress
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" }
    }
})
