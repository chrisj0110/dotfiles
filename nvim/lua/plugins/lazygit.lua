return {
    "kdheepak/lazygit.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        -- optional for floating window border decoration
        vim.g.lazygit_use_custom_config_file_path = 1
        vim.g.lazygit_config_file_path = { os.getenv("HOME") .. "/.config/lazygit/config.yml" }

        vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<cr>", {desc = "open lazygit (cwd)"})
    end
}
