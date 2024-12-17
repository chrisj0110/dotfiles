local setup, lualine = pcall(require, "lualine")
if not setup then return end

-- local custom_dracula = require('lualine.themes.dracula')
local custom_catppuccin = require('lualine.themes.catppuccin')

lualine.setup({
    options = {
        -- theme = custom_dracula,
        theme = custom_catppuccin,
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "|", right = "|" },
        icons_enabled = false,
    },
    sections = {
    --     lualine_a = {'mode'},
    --     lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {{'filename', path = 1}}, -- 0 = just filename, 1 = relative path
    --     lualine_x = {'encoding', 'fileformat', 'filetype'},
    --     lualine_y = {'progress'},
    --     lualine_z = {'location'}
    },
})
