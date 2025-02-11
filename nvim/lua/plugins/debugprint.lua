return {
    "andrewferrier/debugprint.nvim",
    event = "VeryLazy", -- Can't lazy load - required to make line highlighting work before debugprint is first used

    opts = {
        move_to_debugline = true,
        print_tag = "",
        highlight_lines = false,
        keymaps = {
            normal = {
                plain_below = "gp",
                plain_above = "gP",
                -- variable_below = "gv",
                -- variable_above = "gV",
            },
            visual = {
                variable_below = "gp",
                variable_above = "gP",
            },
        },
    },

    -- dependencies = {
    --     "echasnovski/mini.nvim" -- Needed for :ToggleCommentDebugPrints(NeoVim 0.9 only)
    --                             -- and line highlighting (optional)
    -- },

    version = "*", -- Remove if you DON'T want to use the stable version
}
