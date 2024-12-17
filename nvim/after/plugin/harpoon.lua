local harpoon = require("harpoon")
harpoon:setup({
    settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
    },
})

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "T", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<leader>hc", function()  harpoon:list():clear() end)

-- Set <leader>1..<leader>9 be my shortcuts to moving to the files
for _, idx in ipairs { 1, 2, 3, 4, 5, 6, 7, 8, 9 } do
    vim.keymap.set("n", string.format("<leader>%d", idx), function()
        harpoon:list():select(idx)
        harpoon:list()._index = idx
    end)
end

-- swap between windows 1 and 2
vim.keymap.set("n", "t", function()
    if harpoon:list()._index == 1 then
        harpoon:list():select(2)
        harpoon:list()._index = 2
    else
        harpoon:list():select(1)
        harpoon:list()._index = 1
    end
end)

