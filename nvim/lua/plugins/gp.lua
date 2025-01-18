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
                    system_prompt = "Answer any query with just: Sure thing..",
                },
            },
        }
        require("gp").setup(conf)

        vim.keymap.set("n", "<leader>gg", ":GpChatToggle<cr>", {desc = "GPT Prompt toggle"})
        vim.keymap.set("n", "<leader>gn", ":GpChatNew vsplit<cr>", {desc = "GPT Prompt new"})
        vim.keymap.set("v", "<leader>gn", ":<C-u>'<,'>GpChatNew vsplit<cr>", {desc = "GPT Prompt new"})
        vim.keymap.set("v", "<leader>g[", ":<C-u>'<,'>GpChatPaste<cr>", {desc = "GPT Prompt paste"})
        vim.keymap.set("n", "<leader>go", ":GpAppend<cr>", {desc = "GPT Prompt append (with prompt)"})
        vim.keymap.set("v", "<leader>go", ":GpRewrite<cr>", {desc = "GPT Prompt rewrite selected text (with prompt)"})
        vim.keymap.set("v", "<leader>gr", ":GpImplement<cr>", {desc = "GPT Prompt rewrite selected text (no prompt)"})

        -- wish I could remap the tab/shift-tab/etc keys for this:
        vim.keymap.set("n", "<leader>gf", ":GpChatFinder<cr>", {desc = "GPT Prompt chat finder"})

    end,
}
