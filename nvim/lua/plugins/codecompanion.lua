return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "ravitemer/codecompanion-history.nvim",
    },
    opts = {
        opts = {
            log_level = "DEBUG", -- or "TRACE"
        },
        display = { -- https://codecompanion.olimorris.dev/configuration/chat-buffer
            chat = {
                window = {
                    position = "right",
                },
            },
        },
        extensions = {
            history = {
                enabled = true,
                opts = {
                    keymap = "gh",              -- Open history browser from chat
                    save_chat_keymap = "sc",    -- Manual save (if auto_save is off)
                    auto_save = true,           -- Auto-save chats after each response
                    expiration_days = 0,        -- Keep chats forever (set to number to auto-delete old chats)
                    picker = "snacks",          -- or "snacks", "fzf-lua", "default"
                },
            },
        },
        strategies = {
            chat = {
                keymaps = {
                    next_chat = false, -- was "}"
                    previous_chat = false, -- was "{"
                },
            },
        },
    },
    keys = {
        { "<leader>cc", "<cmd>CodeCompanionChat Toggle<CR>", { desc = "Toggle CodeCompanion Chat" } },
        { "<leader>cb", function()
            local line = "in #{buffer}, "
            local row = vim.api.nvim_win_get_cursor(0)[1]
            vim.api.nvim_buf_set_lines(0, row, row, true, { line })
            vim.api.nvim_win_set_cursor(0, { row + 1, #line })
            vim.api.nvim_feedkeys("A", "n", false)
        end, { desc = "CodeCompanion Chat reference Buffer and switch to insert mode" } },
    },
}

