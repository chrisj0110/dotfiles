vim.keymap.set("n", "<leader>gm", ":!git checkout master -- %<CR>");

local gitlab_domain = os.getenv("WORK_GITLAB_DOMAIN")
vim.g.fugitive_gitlab_domains = {gitlab_domain}
