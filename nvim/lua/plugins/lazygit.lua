return {
    "kdheepak/lazygit.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        vim.g.lazygit_use_custom_config_file_path = 1
        vim.g.lazygit_config_file_path = { os.getenv("HOME") .. "/.config/lazygit/config.yml" }

        vim.g.lazygit_floating_window_winblend = 0  -- Make window fully opaque
        vim.g.lazygit_floating_window_scaling_factor = 1.0  -- Use full window size

        vim.keymap.set("n", "<leader>l", "<cmd>LazyGit<cr>", {desc = "open lazygit (cwd)"})
    end
}
