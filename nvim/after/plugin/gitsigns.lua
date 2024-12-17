require('gitsigns').setup()

vim.api.nvim_set_keymap("n", "]g", ":Gitsigns next_hunk<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "[g", ":Gitsigns prev_hunk<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>hd", ":Gitsigns preview_hunk_inline<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>hr", ":Gitsigns reset_hunk<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>gd", ":vertical Gitsigns diffthis<CR>", { noremap = true })
