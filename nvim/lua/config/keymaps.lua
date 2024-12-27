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
vim.api.nvim_set_keymap("n", "<leader>mt", 'vf|?[^ ]<cr>"tymT<leader>e/^translations.json$<cr><cr>G?{<cr>V%YP%A,<esc>2j$hhvi""tPjhdi"jdi":w<cr>\'T', { noremap = false, desc = "add translation" } )
vim.api.nvim_set_keymap("n", "<leader>mu", '-/^translations.json$<cr><cr>G?{<cr>V%YP%a,<esc>2j$hhvi""tPjhdi"jdi":w<cr>\'T', { noremap = false, desc = "go up one level in translations" } )
-- check translation
vim.api.nvim_set_keymap("n", "<leader>mc", 'vf|?[^ ]<cr>"tymT<leader>re"<c-r>t"', { noremap = false, desc = "check translation" } )

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

vim.keymap.set("n", "<leader>sp", ":!echo % | pbcopy<CR>", { noremap = true, desc = "put current path on clipboard" } )

-- create a new file if it doesn't exist
vim.keymap.set("n", "<C-w>f", ":execute 'split ' . expand(\"<cfile>\")<CR>")
vim.keymap.set("n", "gf", ":execute 'edit ' . expand(\"<cfile>\")<CR>")

-- repeat macro over visual block
vim.keymap.set("x", "q", ":normal @q<CR>", { desc = "repeat macro over range" } )

-- open common files
vim.keymap.set("n", "<leader>os", ":e ~/scratch.txt<cr>", { desc = "open scratch" } )
vim.keymap.set("n", "<leader>od", ":e ~/did.txt<cr>", { desc = " open did" } )
vim.keymap.set("n", "<leader>ol", ":e ~/.zshrc-local<cr>", { desc = "open zshrc-local" } )
vim.keymap.set("n", "<leader>op", ":e ~/rust_playground/src/main.rs<cr>", { desc = "open rust playground file" } )
vim.keymap.set("n", "<leader>ot", ":e ~/.config/tmux-sessions.txt<cr>", { desc = "open tmux-sessions file" } )

-- for did.txt, add date and leave it in insert mode
function Diddate()
    local date_str = os.date("%Y-%m-%d")
    vim.cmd("normal! G")
    vim.cmd("normal! o")
    vim.api.nvim_put({"--- " .. date_str .. " ---"}, "c", true, true)
    vim.cmd("normal! o")
    vim.cmd("normal! o")
    vim.cmd("normal! o")
    vim.cmd("normal! k")
    vim.cmd("startinsert!")
end
vim.api.nvim_set_keymap("n", "<leader>id", ":lua Diddate()<CR>", { noremap = true, desc = "insert current date" })

-- next/prev quickfix items
vim.api.nvim_set_keymap("n", "<c-f>", ":cnext<CR>", { noremap = true, desc = "next in quickfix list" })
vim.api.nvim_set_keymap("n", "<c-b>", ":cprev<CR>", { noremap = true, desc = "prev in quickfix list" })

-- next/prev quickfix lists
vim.api.nvim_set_keymap("n", "]q", ":cnewer<CR>", { noremap = true, desc = "next quickfix results" })
vim.api.nvim_set_keymap("n", "[q", ":colder<CR>", { noremap = true, desc = "prev quickfix results" })

local function get_file_and_line()
  local file_path = vim.fn.expand("%")
  local line_number = vim.fn.line(".")
  return file_path, line_number
end

function Open_datadog_link()
    -- open current durst line in datadog dashboard
    local domain = os.getenv("WORK_DATADOG_DOMAIN")
    if not domain then
        print("Error: Missing WORK_DATADOG_DOMAIN environment variable.")
        return
    end

    local file_path, line_number = get_file_and_line()
    file_path = file_path:gsub("/", "%%2F"):gsub(".*products", "products")

    local url = "https://" .. domain .. "/dashboard/nue-gbb-jxy/testcase-history?fromUser=false&refresh_mode=sliding&tpl_var_testcase_line_num%5B0%5D=" .. line_number .. "&tpl_var_testcase_path%5B0%5D=" .. file_path .. "&from_ts=1726575637594&to_ts=1727180437594&live=true"

    local open_command = ":silent !open '" .. url:gsub("%%", "\\%%") .. "'"
    vim.cmd(open_command)
end

vim.api.nvim_set_keymap('n', '<leader>md', ':lua Open_datadog_link()<CR>', { noremap = true, desc = "view test in datadog dashboard" })

function Cargo_build_in_tmux_pane()
  local path = vim.fn.expand('%:p')
  path = string.gsub(path, '/src/.*', '')
  local cmd = 'tmux split-window -v "cd ' .. path .. ' && cargo build --manifest-path Cargo.toml ; exec $SHELL"'
  vim.fn.system(cmd)
end

vim.api.nvim_set_keymap('n', '<leader>mb', ':lua Cargo_build_in_tmux_pane()<CR>', { noremap = true, silent = true, desc = "cargo build current project" })

-- ]s to pull down scratch buffer, [s to close it
local function get_tmux_session_name()
    -- Run the tmux command to get the session name
    local handle = io.popen("tmux display-message -p '#S'")
    if handle == nil then
        return ""
    end
    local session_name = handle:read("*a")
    handle:close()

    -- Trim any trailing whitespace
    session_name = session_name:gsub("%s+", "")
    return session_name
end

function Go_to_last_edit()
    local dot_register = vim.fn.getreg('.')
    local dot_mark = vim.fn.getpos("'.")

    if dot_register == '' then
        -- not modified in current session
        return
    end

    if dot_mark[2] <= 0 or dot_mark[2] > vim.fn.line('$') then
        -- line for last edit location doesn't exist
        return
    end

    vim.cmd("normal! '.")
end

function Toggle_scratch(vertical)
    local tmux_session = get_tmux_session_name()
    local scratch_file = "~/scratch-" .. tmux_session .. ".txt"

    local buf = vim.fn.bufnr(scratch_file)
    if buf == -1 then
        if vertical then
            vim.cmd('set splitright')
            vim.cmd('vsplit ' .. scratch_file)
            vim.cmd('set nosplitright')
            vim.cmd('vertical resize 70')
        else
            vim.cmd('set nosplitbelow')
            vim.cmd('silent! split ' .. scratch_file)
            vim.cmd('set splitbelow')
            vim.cmd('resize 15')
        end
    else
        -- Close the window containing the scratch file if it's open
        for _, win in ipairs(vim.api.nvim_list_wins()) do
            if vim.api.nvim_win_get_buf(win) == buf then
                vim.cmd('bdelete ' .. buf)
                return
            end
        end
        -- if the buffer exists but not in a window, open in a new split
        if vertical then
            vim.cmd('set splitright')
            vim.cmd('vsplit | buffer ' .. buf)
            vim.cmd('set nosplitright')
            vim.cmd('vertical resize 70')
        else
            vim.cmd('set nosplitbelow')
            vim.cmd('split | buffer ' .. buf)
            vim.cmd('set splitbelow')
            vim.cmd('resize 15')
        end
    end
    Go_to_last_edit()
end

vim.api.nvim_set_keymap('n', '[s', ':lua Toggle_scratch(false)<CR>', { noremap = true, silent = true, desc = "toggle scratch horizontal" })
vim.api.nvim_set_keymap('n', ']s', ':lua Toggle_scratch(true)<CR>', { noremap = true, silent = true, desc = "toggle scratch vertical" })

-- not sure if needed after switching to lazyvim:
-- vim.keymap.set("i", "<s-tab>", "<c-d>")

