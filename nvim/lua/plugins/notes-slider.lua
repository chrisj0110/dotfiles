return {
    "chrisj0110/notes-slider",
    -- dir = "~/notes-slider",
    -- dev = true,
    config = function()
        require('notes-slider').setup({
            notes_file_prefix = "scratch-",
            -- notes_file_extension = "md",
            -- notes_file_dir = "~/bin",
        })

        vim.opt.equalalways = false -- Disable automatic resizing of splits

        vim.api.nvim_set_keymap('n', '[s', ':aboveleft split | wincmd K | resize 15<CR>:lua require("notes-slider").open_notes_using_tmux_session_name()<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', ']s', ':vsplit | wincmd R | vertical resize 70<CR>:lua require("notes-slider").open_notes_using_tmux_session_name()<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '-s', ':lua require("notes-slider").open_notes_using_tmux_session_name()<CR>', { noremap = true, silent = true })
    end,
}
