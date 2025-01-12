return {
    'echasnovski/mini.hipatterns',
    version = false,
    config = function()
        local hipatterns = require('mini.hipatterns')
        hipatterns.setup({
            highlighters = {
                -- code for custom color figured out from https://github.com/echasnovski/mini.nvim/discussions/1024
                todo = { pattern = '%f[%w]()TODO()%f[%W]', group = hipatterns.compute_hex_color_group('#fab387', 'fg') },

                -- Highlight hex color strings (`#rrggbb`) using that color
                hex_color = hipatterns.gen_highlighter.hex_color(),
            },
        })
    end
}
