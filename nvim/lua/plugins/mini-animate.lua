return {
    'echasnovski/mini.animate',
    version = false,
    config = function()
        -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-animate.md
        local animate = require('mini.animate')
        animate.setup({
            cursor = {
                timing = animate.gen_timing.linear({ duration = 50, unit = 'total' }),
            },
            scroll = {
                timing = animate.gen_timing.linear({ duration = 50, unit = 'total' }),
            },
        })
    end
}
