require("workspaces").setup({
    sort = true,
    mru_sort = true,
    -- hooks = {
    --     open = { "let folder_name = fnamemodify(getcwd(), ':t')", "silent execute '!tmux rename-window ' . folder_name" }
    -- }
})

