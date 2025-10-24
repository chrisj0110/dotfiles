return {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    keys = {
        {
            "]g", ":Gitsigns next_hunk<CR>", { noremap = true }
        },
        {
            "[g", ":Gitsigns prev_hunk<CR>", { noremap = true }
        },
        {
            "<leader>hd", ":Gitsigns preview_hunk_inline<CR>", { noremap = true }
        },
        {
            "<leader>hr", ":Gitsigns reset_hunk<CR>", { noremap = true }
        },
        -- {
        --     "<leader>gD", ":vertical Gitsigns diffthis<CR>", { noremap = true }
        -- },
    },
    config = function()
        require('gitsigns').setup()
    end,
}
