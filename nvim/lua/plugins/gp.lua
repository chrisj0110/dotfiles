-- https://github.com/Robitx/gp.nvim
return {
    "robitx/gp.nvim",
    config = function()
        local conf = {
            providers = {
                copilot = {
                    endpoint = "https://api.githubcopilot.com/chat/completions",
                    secret = {
                        "bash",
                        "-c",
                        "cat ~/.config/github-copilot/hosts.json | sed -e 's/.*oauth_token...//;s/\".*//'",
                    },
                },
            },
            agents = {
                {
                    name = "ChatGPT3-5",
                    disable = true,
                },
                {
                    name = "MyCustomAgent",
                    provider = "copilot",
                    chat = true,
                    command = true,
                    model = { model = "gpt-4-turbo" },
                    system_prompt = require("gp.defaults").chat_system_prompt,
                },
            },
        }
        require("gp").setup(conf)

        local add_default_prompt = function()
            local default_prompt = "Don't give me any explanations or extra context, just give me the answer. If I need more information I will ask in a follow-up question."
            vim.cmd("startinsert")
            vim.api.nvim_put({default_prompt, "", ""}, "l", true, true)
        end

        vim.keymap.set("n", "<leader>gn", function()
            vim.cmd("GpChatNew tabnew")
            add_default_prompt()
        end, {desc = "GPT Prompt new"})
        vim.keymap.set("n", "<leader>gg", "<cmd>GpChatToggle tabnew<cr>", {desc = "GPT Prompt toggle"})
        vim.keymap.set("v", "<leader>g]", ":<C-u>'<,'>GpChatPaste tabnew<cr>", {desc = "GPT Prompt paste"})

        vim.keymap.set("v", "<leader>gi", ":GpImplement<cr>", {desc = "GPT Prompt rewrite selected text (no prompt)"})

        -- until I figure out how to make this the default prompt:
        -- vim.keymap.set("n", "<leader>gq", "iDon't give me any explanations or extra context, just give me the answer. If I need more information I will ask in a follow-up question.<cr><cr>", {desc = "GPT Prompt quick answer"})
    end,
}
