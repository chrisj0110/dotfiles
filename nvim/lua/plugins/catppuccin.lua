return {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
        no_underline = true,
        integrations = {
            harpoon = true,
            mason = true,
            cmp = true,
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = { "italic" },
                    hints = { "italic" },
                    warnings = { "italic" },
                    information = { "italic" },
                },
                underlines = {
                    errors = { "underline" },
                    hints = { "underline" },
                    warnings = { "underline" },
                    information = { "underline" },
                },
                inlay_hints = {
                    background = true,
                },
            },
            treesitter = true,
            telescope = {
                enabled = true,
            },
        },
    },
    config = function(_, opts)
        require("catppuccin").setup(opts)
        vim.cmd([[colorscheme catppuccin-mocha]])
    end,
}

