-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Remap Y to behave like yy
vim.keymap.set("n", "Y", "yy", { desc = "Yank entire line (like yy)" })
