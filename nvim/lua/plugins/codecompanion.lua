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

        { "<leader>cn", function()
            vim.cmd("CodeCompanionChat")
            vim.defer_fn(function()
                vim.cmd("normal! gx")
            end, 100) -- ms
        end, { desc = "New CodeCompanion" } },

        { "<leader>cl", function()
            vim.cmd("wincmd h")
            local bufname = vim.fn.expand("%:.")
            vim.cmd("wincmd l")
            vim.defer_fn(function()
                vim.cmd("normal! i#{buffer:" .. bufname .. "} ")
            end, 100) -- ms
        end, { desc = "Copy other buffer (from chat window) and write to the chat window" } },

    },
}

