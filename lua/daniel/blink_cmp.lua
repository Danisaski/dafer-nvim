return {
    keymap = { preset = 'super-tab' },
    appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'normal'
    },
    completion = {
        keyword = { range = 'prefix' }, -- Check if prefix better
        list = {
            selection = { preselect = true, auto_insert = false } },

        -- Insert completion item on selection, don't select by default
        menu = {
            -- nvim-cmp style menu
            draw = {
                treesitter = { 'lsp' },
                columns = {
                    { "label",     "label_description", gap = 1 },
                    { "kind_icon", "kind" }
                },
            },
            border = 'rounded',
            scrollbar = false,
        },
        -- Show documentation when selecting a completion item
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 500,
            treesitter_highlighting = true,
            window = { border = 'rounded' }
        },

        -- Display a preview of the selected item on the current line
        ghost_text = { enabled = false },
    },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
}
