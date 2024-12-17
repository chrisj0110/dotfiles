vim.keymap.set("n", "<leader>gb", ":tabfirst<CR>:tabonly<CR>:lua require('diffview').open(require('telescope.utils').get_os_command_output({'git', 'merge-base', 'HEAD', 'master'})[1] .. '..HEAD')<CR>")

