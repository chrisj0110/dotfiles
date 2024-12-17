vim = vim

-- vim.keymap.set("n", "<leader>gs", ":Git<CR><C-W>o");
-- vim.keymap.set("n", "<leader>gp", ":G pull<CR>");
-- vim.keymap.set("n", "<leader>gP", ":G push<CR>");
-- vim.keymap.set("n", "<leader>gb", ":G branch --sort=-committerdate<CR>");
-- vim.keymap.set("n", "<leader>gm", ":G checkout master<CR>");

vim.keymap.set("n", "<leader>gm", ":!git checkout master -- %<CR>");

local gitlab_domain = os.getenv("WORK_GITLAB_DOMAIN")
vim.g.fugitive_gitlab_domains = {gitlab_domain}

