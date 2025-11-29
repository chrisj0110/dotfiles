return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
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
        { "<leader>cc", "<cmd>CodeCompanionChat Toggle<CR>", { desc = "Toggle CodeCompanion Chat" } }
    },
}

