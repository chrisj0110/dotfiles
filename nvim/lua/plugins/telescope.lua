return {
    "nvim-telescope/telescope.nvim",
    version = "0.1.5",
    dependencies = { { "nvim-lua/plenary.nvim" } },
    config = function()
        local builtin = require('telescope.builtin')

        -- smart-case:
        local function my_smartcase_search(search_string)
            builtin.live_grep({
                default_text = search_string,
                additional_args = function()
                    return { "--hidden", "--glob", "!.git/**" }
                end,
            })
        end

        vim.keymap.set('n', '<leader>re', function()
            my_smartcase_search()
        end, { desc = "live_grep" })

        -- smart-case search for visual selection
        vim.keymap.set("v", "<leader>mv", function()
            vim.cmd('normal! "py')
            local selection = vim.fn.getreg('p')
            my_smartcase_search(selection)
        end, { noremap = true, silent = true, desc = "visual-mode live_grep" })

        -- til files
        vim.keymap.set('n', '<leader>tf', function()
            builtin.find_files({
                cwd = "~/til",
            })
        end, { desc = 'Find files in target directory' })

        -- til grep
        vim.keymap.set("n", "<leader>ti", function()
            builtin.live_grep({
                cwd = "~/til",
                search = "",
                additional_args = function()
                    return { "--hidden", "--glob", "!.git/**" }
                end,
            })
        end, { noremap = true, desc = "TIL grep" })

        vim.api.nvim_set_keymap('n', '<leader>tr', ':Telescope buffers sort_mru=true<CR>', { noremap = true })
        vim.api.nvim_set_keymap('n', '<leader>to', ':Telescope oldfiles sort_mru=true<CR>', { noremap = true })
        vim.api.nvim_set_keymap('n', '<leader>tg', ':Telescope registers<CR>', { noremap = true })
        vim.api.nvim_set_keymap('n', '<leader>tl', ':Telescope luasnip<CR>', { noremap = true })
        vim.api.nvim_set_keymap('n', '<leader>tk', ':Telescope keymaps<CR>', { noremap = true })
        vim.api.nvim_set_keymap('i', '<c-]><c-l>', '<space><cmd>Telescope luasnip<CR>', { noremap = true })

        local telescope = require('telescope')
        telescope.load_extension('luasnip')
        telescope.load_extension('harpoon') -- ":Telescope harpoon marks"

        local actions = require('telescope.actions')
        telescope.setup {
            defaults = {
                layout_config = {
                    horizontal = { height = 0.95, width = 0.95 },
                },
                mappings = {
                    i = {
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        -- ["<C-s>"] = actions.send_selected_to_qflist + actions.open_qflist,
                        -- ["<C-f>"] = actions.results_scrolling_down,
                        -- ["<C-b>"] = actions.results_scrolling_up,
                        ["<C-f>"] = actions.to_fuzzy_refine,
                        ["<C-l>"] = actions.send_to_qflist + actions.open_qflist,
                    },
                    n = {
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        -- ["<C-s>"] = actions.send_selected_to_qflist + actions.open_qflist,
                        -- ["<C-f>"] = actions.results_scrolling_down,
                        -- ["<C-b>"] = actions.results_scrolling_up,
                        ["<C-f>"] = actions.to_fuzzy_refine,
                        ["<C-l>"] = actions.send_to_qflist + actions.open_qflist,
                    },
                },
            },
        }
    end
}
