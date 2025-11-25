return {
    "pianocomposer321/officer.nvim",
    dependencies = "stevearc/overseer.nvim",
    config = function()
        -- Setup officer
        require("officer").setup {
            create_mappings = false,  -- we'll set custom ones below
        }

        -- Override makeprg for Rust files (runs after ftplugin)
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "rust",
            callback = function()
                vim.bo.makeprg = "bazel build //stapp/..."

                -- Configure errorformat for Rust compiler output
                vim.bo.errorformat = table.concat({
                    '%Eerror: %m',
                    '%Eerror[E%n]: %m',
                    '%Wwarning: %m',
                    '%Inote: %m',
                    '%C %#--> %f:%l:%c',
                    '%-G%.%#',  -- ignore other lines
                }, ',')
            end,
        })

        -- Keybindings
        vim.keymap.set('n', '<leader>bb', function()
            vim.cmd('Make')
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-w>h', true, false, true), 'n', false)
        end, { desc = 'Bazel build (default) and send <C-h>' })
        vim.keymap.set('n', '<leader>bt', ':Make test //...<CR>', { desc = 'Bazel test all' })
        vim.keymap.set('n', '<leader>bm', ':Make ', { desc = 'Bazel build (specify target)' })

        -- Stop/kill running build
        vim.keymap.set('n', '<leader>bk', function()
            local overseer = require('overseer')
            local tasks = overseer.list_tasks({ recent_first = true })
            if tasks[1] then
                tasks[1]:stop()
                vim.notify('Build stopped')
            end
        end, { desc = 'Kill running build' })
    end,
}

