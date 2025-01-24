-- lua/daniel/theme.lua
local M = {}

function M.setup()
    vim.g.gruvbox_material_enable_italic = true
    vim.g.gruvbox_material_diagnostic_line_highlight = true
    vim.g.gruvbox_material_diagnostic_text_highlight = true
    vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
    vim.g.gruvbox_material_enable_bold = true
    vim.g.gruvbox_material_ui_contrast = 'high'
    vim.g.gruvbox_material_inlay_hints_background = 'dimmed'
    vim.g.gruvbox_material_show_eob = false
    -- vim.g.gruvbox_material_float_style='dim'
    -- vim.g.gruvbox_material_transparent_background=2
    -- vim.g.gruvbox_material_dim_inactive_windows = true
    vim.cmd.colorscheme('gruvbox-material')
    vim.api.nvim_set_hl(0, 'FloatBorder', { link = 'Normal' }) -- Fix background color border
end

return M
