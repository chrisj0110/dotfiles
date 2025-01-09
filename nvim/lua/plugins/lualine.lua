return {
    "nvim-lualine/lualine.nvim",
    config = function()
        local setup, lualine = pcall(require, "lualine")
        if not setup then return end

        local custom_catppuccin = require('lualine.themes.catppuccin')

        -- populate harpoon list thanks to https://github.com/ThePrimeagen/harpoon/issues/352#issuecomment-1873053256
        local yellow = '#f9e2af'
        local peach = '#fab387'
        local active_background_color = '#313244'
        local background_color = '#1e1e2e'
        local grey = '#6c7086'
        local light_blue = '#74c7ec'
        vim.api.nvim_set_hl(0, "HarpoonInactive", { fg = grey, bg = background_color })
        vim.api.nvim_set_hl(0, "HarpoonActive", { fg = light_blue, bg = active_background_color })
        vim.api.nvim_set_hl(0, "HarpoonNumberActive", { fg = yellow, bg = active_background_color })
        vim.api.nvim_set_hl(0, "HarpoonNumberInactive", { fg = peach, bg = background_color })
        vim.api.nvim_set_hl(0, "TabLineFill", { fg = "white", bg = background_color })

        local harpoon = require('harpoon')

        function Harpoon_files()
          local contents = {}
          local marks_length = harpoon:list():length()
          local current_file_path = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")
          for index = 1, marks_length do
            local harpoon_file_path = harpoon:list():get(index).value

            local label = ""
            if vim.startswith(harpoon_file_path, "oil") then
              local dir_path = string.sub(harpoon_file_path, 7)
              dir_path = vim.fn.fnamemodify(dir_path, ":.")
              label = '[' .. dir_path .. ']'
            elseif harpoon_file_path ~= "" then
              label = vim.fn.fnamemodify(harpoon_file_path, ":t")
            end

            label = label ~= "" and label or "(empty)"
            if current_file_path == harpoon_file_path then
              contents[index] = string.format("%%#HarpoonNumberActive# %s. %%#HarpoonActive#%s ", index, label)
            else
              contents[index] = string.format("%%#HarpoonNumberInactive# %s. %%#HarpoonInactive#%s ", index, label)
            end
          end

          return table.concat(contents)
        end


        lualine.setup({
            options = {
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
                lualine_x = {{ Harpoon_files }},
                lualine_y = {'searchcount', 'progress'},
            --     lualine_z = {'location'}
            },
        })

    end,
}
