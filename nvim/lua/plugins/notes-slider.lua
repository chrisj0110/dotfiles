return {
    "chrisj0110/notes-slider",
    -- dir = "~/notes-slider",
    -- dev = true,
    config = function()
        require('notes-slider').setup({
            horizontal_split_size = 15,
            vertical_split_size = 70,
            scratch_file_prefix = "scratch-",
            -- scratch_file_extension = "md",
            -- scratch_file_dir = "~/bin",
        })

        vim.api.nvim_set_keymap('n', '[s', ':lua require("notes-slider").toggle_scratch_using_tmux_name(false, false)<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', ']s', ':lua require("notes-slider").toggle_scratch_using_tmux_name(true, true)<CR>', { noremap = true, silent = true })
    end,
}
