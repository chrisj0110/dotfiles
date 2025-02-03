return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require('gitsigns').setup()

        vim.api.nvim_set_keymap("n", "]g", ":Gitsigns next_hunk<CR>", { noremap = true })
        vim.api.nvim_set_keymap("n", "[g", ":Gitsigns prev_hunk<CR>", { noremap = true })
        vim.api.nvim_set_keymap("n", "<leader>hd", ":Gitsigns preview_hunk_inline<CR>", { noremap = true })
        vim.api.nvim_set_keymap("n", "<leader>hr", ":Gitsigns reset_hunk<CR>", { noremap = true })
        vim.api.nvim_set_keymap("n", "<leader>gD", ":vertical Gitsigns diffthis<CR>", { noremap = true })
    end,
}
