-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Remap Y to behave like yy
vim.keymap.set("n", "Y", "yy", { desc = "Yank entire line (like yy)" })

-- yank to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "yank to clipboard" } )
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "yank to clipboard" } )
vim.keymap.set({"n", "v"}, "<leader>d", [["+d]], { desc = "delete to clipboard" } )

vim.keymap.set("n", "'", "`", { desc = "jump to mark at both row and column" } )

-- theprimagen mappings
vim.keymap.set("v", "<tab>", ":m '>+1<CR>gv=gv", { desc = "move lines down" } )
vim.keymap.set("v", "<s-tab>", ":m '<-2<CR>gv=gv", { desc = "move lines up" } )
vim.keymap.set("n", "J", "mzJ`z", { desc = "jump to desired column when joining?" } )
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "page down" } )
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "page up" } )
vim.keymap.set("n", "n", "nzzzv", { desc = "go next and center line" } )
vim.keymap.set("n", "N", "Nzzzv", { desc = "go previous and center line" } )

---- macros

-- add translation
vim.api.nvim_set_keymap("n", "<leader>mt", 'vf|?[^ ]<cr>"tymT<leader>e/^translations.json$<cr><cr>G?{<cr>V%YP%A,<esc>2j$hhvi""tPjhdi"jdi":w<cr>\'T', { noremap = false }, { desc = "add translation" } )
vim.api.nvim_set_keymap("n", "<leader>mu", '-/^translations.json$<cr><cr>G?{<cr>V%YP%a,<esc>2j$hhvi""tPjhdi"jdi":w<cr>\'T', { noremap = false }, { desc = "go up one level in translations" } )
-- check translation
vim.api.nvim_set_keymap("n", "<leader>mc", 'vf|?[^ ]<cr>"tymT<leader>re"<c-r>t"', { noremap = false }, { desc = "check translation" } )

-- format json from clipboard to clipboard
vim.keymap.set("n", "<leader>mj", ":silent !pbpaste | jq | pbcopy<CR>", { desc = "format json on clipboard" } )
vim.keymap.set("n", "<leader>mx", ":silent !pbpaste | xmllint --format - | pbcopy<CR>", { desc = "format xml on clipboard" } )

local function jump_to_log_line(root_file_path)
    local current_line = vim.api.nvim_get_current_line()
    local full_file_path = string.match(current_line, "\"filename\":\"(.-)\"")
    local line_number = string.match(current_line, "\"line_number\":(.-)[,}]")
    if root_file_path == "" then
        vim.cmd(":e " .. full_file_path)
    else
        local file_path = string.match(full_file_path, "src/.*")
        vim.cmd(":e " .. root_file_path .. "/" .. file_path)
    end
    vim.cmd(":" .. line_number)
end

vim.keymap.set("n", "<leader>sf", function()
    jump_to_log_line("")
end, { desc = "jump to file and line found in current .log line"})

-- this will be unneeded soon anyway:
-- vim.keymap.set("n", "<leader>sk", function()
--     jump_to_log_line("~/dev/koios/rust/koios")
-- end, { desc = "jump to koios file and line found in current .log line"})

---- end macros

-- format based on filetype:
vim.keymap.set('n', '<leader>fm', function()
    local ft = vim.bo.filetype
    if ft == 'cucumber' then
        vim.cmd(':silent !prettier --write %')
    elseif ft == 'rust' then
        vim.lsp.buf.format { async = true }
    else
        print('No action defined for filetype: ' .. ft)
    end
end, { desc = "format file" })

vim.keymap.set("n", "<leader>sp", ":!echo % | pbcopy<CR>", { noremap = true }, { desc = "put current path on clipboard" } )

-- create a new file if it doesn't exist
vim.keymap.set("n", "<C-w>f", ":execute 'split ' . expand(\"<cfile>\")<CR>")
vim.keymap.set("n", "gf", ":execute 'edit ' . expand(\"<cfile>\")<CR>")

-- repeat macro over visual block
vim.keymap.set("x", "q", ":normal @q<CR>", { desc = "repeat macro over range" } )

-- not sure if needed after switching to lazyvim:
-- vim.keymap.set("i", "<s-tab>", "<c-d>")

