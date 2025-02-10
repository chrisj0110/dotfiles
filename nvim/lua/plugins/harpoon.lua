return {
    "ThePrimeagen/harpoon",
    event = "VeryLazy",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup({
            settings = {
                save_on_toggle = true,
                sync_on_ui_close = true,
            },
        })

        vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, {desc = "add to harpoon"})
        vim.keymap.set("n", "<leader>hl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {desc = "harpoon list"})
        vim.keymap.set("n", "<leader>hc", function()  harpoon:list():clear() end, {desc = "clear harpoon"})

        -- Set <leader>1..<leader>9 be my shortcuts to moving to the files
        for _, idx in ipairs { 1, 2, 3, 4, 5, 6, 7, 8, 9 } do
            vim.keymap.set("n", string.format("<leader>%d", idx), function()
                harpoon:list():select(idx)
                harpoon:list()._index = idx
            end)
        end

    end,
}

