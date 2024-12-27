return {
    {
        "tpope/vim-fugitive",
        config = function()
            vim.keymap.set("n", "<leader>gm", ":!git checkout master -- %<CR>")
        end,
    },
    {
        "shumphrey/fugitive-gitlab.vim",
        config = function()
            local gitlab_domain = os.getenv("WORK_GITLAB_DOMAIN")
            if gitlab_domain then
                vim.g.fugitive_gitlab_domains = { gitlab_domain }
            else
                vim.notify("WORK_GITLAB_DOMAIN is not set!", vim.log.levels.WARN)
            end
        end,
    },
}

