require("oil").setup({
    columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
    },
    use_default_keymaps = false,
    keymaps = {
        ["g?"] = { "actions.show_help", mode = "n" },
        ["<CR>"] = "actions.select",
        -- ["<C-s>"] = { "actions.select", opts = { vertical = true } },
        -- ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
        -- ["<C-t>"] = { "actions.select", opts = { tab = true } },
        -- ["<C-p>"] = "actions.preview",
        ["<C-c>"] = { "actions.close", mode = "n" },
        -- ["<C-l>"] = "actions.refresh",
        ["-"] = { "actions.parent", mode = "n" },
        ["_"] = { "actions.open_cwd", mode = "n" },
        ["`"] = { "actions.cd", mode = "n" },
        ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
        ["gs"] = { "actions.change_sort", mode = "n" },
        ["gx"] = "actions.open_external",
        ["g."] = { "actions.toggle_hidden", mode = "n" },
        ["g\\"] = { "actions.toggle_trash", mode = "n" },
    },
    git = {
        -- Return true to automatically git add/mv/rm files
        add = function(path)
            return true
        end,
        mv = function(src_path, dest_path)
            return true
        end,
        rm = function(path)
            return true
        end,
    },
})

vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", {desc = "Open buffer's dir in Oil"})
vim.keymap.set("n", "<leader>E", "<cmd>Oil .<cr>", {desc = "Open cwd in Oil"})

