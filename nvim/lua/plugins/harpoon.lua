return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup({
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
      },
    })

    vim.keymap.set("n", "<leader>ha", function()
      harpoon:list():add()
    end, { desc = "harpoon add" })
    vim.keymap.set("n", "<leader>hl", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "harpoon list" })

    -- Set <leader>1..<leader>9 be my shortcuts to moving to the files
    for _, idx in ipairs({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }) do
      vim.keymap.set("n", string.format("<leader>%d", idx), function()
        harpoon:list():select(idx)
        harpoon:list()._index = idx
      end, { desc = "harpoon switch to file" })
    end
  end,
}
