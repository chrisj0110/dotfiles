return {
    'echasnovski/mini.hipatterns',
    version = false,
    config = function()
        local hipatterns = require('mini.hipatterns')
        hipatterns.setup({
            highlighters = {
                todo = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },

                -- Highlight hex color strings (`#rrggbb`) using that color
                hex_color = hipatterns.gen_highlighter.hex_color(),
            },
        })
    end
}
