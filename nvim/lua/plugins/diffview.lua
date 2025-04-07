return {
    "sindrets/diffview.nvim",
    lazy = true,
    keys = {
        {
            "<leader>gb", ":tabfirst<CR>:tabonly<CR>:lua require('diffview').open('origin/master...HEAD')<CR>"
        },
    },
}
