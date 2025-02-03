return {
    "nvim-telescope/telescope.nvim",
    version = "0.1.5",
    dependencies = { { "nvim-lua/plenary.nvim" } },
    config = function()
        local builtin = require('telescope.builtin')

        vim.api.nvim_set_keymap('n', '<leader>tl', ':Telescope luasnip<CR>', { noremap = true })

        local telescope = require('telescope')
        telescope.load_extension('luasnip')

        local actions = require('telescope.actions')
        telescope.setup {
            defaults = {
                layout_config = {
                    horizontal = { height = 0.95, width = 0.95 },
                },
                mappings = {
                    i = {
                        ["<C-n>"] = actions.move_selection_next,
                        ["<C-p>"] = actions.move_selection_previous,
                        -- ["<C-s>"] = actions.send_selected_to_qflist + actions.open_qflist,
                        -- ["<C-f>"] = actions.results_scrolling_down,
                        -- ["<C-b>"] = actions.results_scrolling_up,
                        ["<C-f>"] = actions.to_fuzzy_refine,
                        ["<C-l>"] = actions.send_to_qflist + actions.open_qflist,
                    },
                    n = {
                        ["<C-n>"] = actions.move_selection_next,
                        ["<C-p>"] = actions.move_selection_previous,
                        -- ["<C-s>"] = actions.send_selected_to_qflist + actions.open_qflist,
                        -- ["<C-f>"] = actions.results_scrolling_down,
                        -- ["<C-b>"] = actions.results_scrolling_up,
                        ["<C-f>"] = actions.to_fuzzy_refine,
                        ["<C-l>"] = actions.send_to_qflist + actions.open_qflist,
                    },
                },
            },
            extensions = {
                frecency = {
                    db_safe_mode = false, -- Disable safe mode
                },
            },
        }
    end
}
