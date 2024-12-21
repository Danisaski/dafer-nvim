return {
    keymap = { preset = 'super-tab' },
    appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = 'normal'
    },
    completion = {
        keyword = { range = 'full' },
        -- Insert completion item on selection, don't select by default
        list = { selection = 'auto_insert' },
        menu = {
            -- nvim-cmp style menu
            draw = {
                columns = {
                    { "label",     "label_description", gap = 1 },
                    { "kind_icon", "kind" }
                },
            }
        },
        -- Show documentation when selecting a completion item
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
        -- Display a preview of the selected item on the current line
        ghost_text = { enabled = true },
    },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
}
