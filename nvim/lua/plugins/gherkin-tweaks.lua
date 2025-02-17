return {
    "chrisj0110/gherkin-tweaks",
    -- dir = "~/gherkin-tweaks",
    -- dev = true,
    config = function()
        local gherkin_tweaks = require('gherkin-tweaks')
        gherkin_tweaks.setup({
            -- tag = '@cj',
            auto_save = true,
        })

        vim.keymap.set('n', '<leader>mi', function()
            gherkin_tweaks.add_tag_to_section("@live")
            gherkin_tweaks.isolate_test("@cj")
        end, { desc = 'Isolate just this gherkin test' })

        vim.keymap.set('n', '<leader>mj', function()
            gherkin_tweaks.add_tag_to_section("@live")
            gherkin_tweaks.add_tag_to_section("@cj")
        end, { desc = 'Add tag to the top of the current gherkin section' })

        vim.keymap.set('n', '<leader>me', function()
            gherkin_tweaks.copy_table_header()
        end,
        { desc = 'Copy the previous gherkin table header above the current line' })
    end
}
