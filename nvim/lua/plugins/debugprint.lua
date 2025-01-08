return {
    "andrewferrier/debugprint.nvim",

    opts = {
        move_to_debugline = true,
    },

    dependencies = {
        "echasnovski/mini.nvim" -- Needed for :ToggleCommentDebugPrints(NeoVim 0.9 only)
                                -- and line highlighting (optional)
    },

    lazy = false, -- Required to make line highlighting work before debugprint is first used
    version = "*", -- Remove if you DON'T want to use the stable version
}
