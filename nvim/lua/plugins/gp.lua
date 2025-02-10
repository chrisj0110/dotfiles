-- https://github.com/Robitx/gp.nvim
return {
    "robitx/gp.nvim",
    lazy = true,
    keys = {
        {
            "<leader>gn", function()
                vim.cmd("GpChatNew tabnew")
                vim.cmd("startinsert")
                vim.api.nvim_put(
                    {
                        "Don't give me any explanations or extra context, just give me the answer. If I need more information I will ask in a follow-up question.",
                        "",
                        ""
                    },
                    "l", true, true
                )
            end, desc = "GPT Prompt new",
        },
        {
            "<leader>gg", "<cmd>GpChatToggle tabnew<cr>", {desc = "GPT Prompt toggle"}
        },
        {
            "<leader>g]", ":<C-u>'<,'>GpChatPaste tabnew<cr>", mode = "v", {desc = "GPT Prompt paste"}
        },
        {
            "<leader>gi", ":GpImplement<cr>", mode = "v", {desc = "GPT Prompt rewrite selected text (no prompt)"}
        },
    },
    config = function()
        require("gp").setup({
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
        })
    end,
}
