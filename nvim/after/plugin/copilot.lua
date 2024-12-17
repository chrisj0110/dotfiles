# see instruction steps here: https://github.com/github/copilot.vim?tab=readme-ov-file

-- commented this out to speed up neovim start time
-- vim.cmd(":Copilot disable") -- start disabled

vim.keymap.set('i', '<c-]><c-]>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true

vim.keymap.set('n', '<leader>cc', ':Copilot enable<CR>', { noremap = true })
vim.keymap.set('n', '<leader>cx', ':Copilot disable<CR>', { noremap = true })
