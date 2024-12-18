vim = vim  -- so that we only get one info message here, instead of warnings everywhere else about the vim variable

vim.g.mapleader = " "

vim.keymap.set("n", "<leader>E", ":e .<CR>")
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

vim.keymap.set("n", "'", "`")

-- not sure if this is needed, but tab was switching to a different buffer for me at one point:
-- .. but then having it seemed to break <c-i>?
-- vim.api.nvim_set_keymap('n', '<Tab>', '<Nop>', { noremap = true, silent = true })

vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

---- start of primeagen mappings

-- this has to be visual mode only - in normal mode tab is the same as <c-i> which breaks navigation
vim.keymap.set("v", "<tab>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<s-tab>", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<c-t>", "<nop>")

vim.keymap.set({"n", "v"}, "<leader>d", [["+d]])

---- end of primeagen mappings

---- macros

-- get the jira story from the commit template
vim.api.nvim_set_keymap("n", "<leader>ms", "/# On branch<CR>3WvEyggO<c-r>\"<CR><esc>kf-;C: ", { noremap = true })

-- add @cj and comment out all but current cucumber test
vim.keymap.set("n", "<leader>mi", function()
    -- add tag
    local starting_line = vim.fn.line('.')
    vim.cmd('normal! {')
    vim.cmd('normal! o@cj')
    local section_start_line = vim.fn.line(".")

    -- got the start line above, now get the end line
    vim.cmd('normal! }')
    local section_end_line = vim.fn.line(".")

    -- comment out all tests, but not the first line which has the column headers
    local first_example_line_found = false
    for i = section_start_line, section_end_line do
        -- loop through the lines, get the content of each, comment out all except the first one
        if not first_example_line_found and vim.api.nvim_buf_get_lines(0, i - 1, i, false)[1]:find("|", 1, true) then
            first_example_line_found = true
        else
            -- also don't comment out the test we want to run
            if i ~= starting_line + 1 then
                local line = vim.fn.getline(i)
                local updated_line = line:gsub("|", "# |", 1)
                vim.fn.setline(i, updated_line)
            end
        end
    end

    vim.api.nvim_win_set_cursor(0, {starting_line + 1, 0})
    vim.cmd(':w')
end, {desc = "isolate just this test"})

vim.keymap.set("n", "<leader>mj", function()
    local starting_line = vim.fn.line('.')
    vim.cmd('normal! {')
    vim.cmd('normal! o@cj')
    vim.api.nvim_win_set_cursor(0, {starting_line + 1, 0})
    vim.cmd(':w')
end, {desc = "add tag to top of section"})

-- run the next test
vim.api.nvim_set_keymap("n", "<leader>mn", "u''j mi", { noremap = false })

-- add Example lines in cucumber file
vim.keymap.set("n", "<leader>me", function()
    local starting_line = vim.fn.line('.')

    vim.cmd('normal! {')
    local empty_line_above_section = vim.fn.line(".")

    -- find the next line that starts with "|", which is the header row
    local header_row = 0
    for i = empty_line_above_section, vim.api.nvim_buf_line_count(0) do
        if vim.api.nvim_buf_get_lines(0, i - 1, i, false)[1]:find("|", 1, true) then
            header_row = i
            break
        end
    end

    -- yank the lines we want
    vim.cmd(':' .. empty_line_above_section .. ',' .. header_row .. 'y')

    -- go to our test line and paste it in
    vim.api.nvim_win_set_cursor(0, {starting_line, 0})
    vim.cmd('normal! P')

    -- now go to the new test line, and save
    vim.api.nvim_win_set_cursor(0, {1 + starting_line + header_row - empty_line_above_section, 0})
    vim.cmd(':w')
end, {desc = "copy table header above the current test"})

-- remove @cj from buffer
vim.api.nvim_set_keymap("n", "<leader>mx", ":g/^\\s*@cj\\s*$/d<cr>:w<esc>", { noremap = false })

-- add translation
vim.api.nvim_set_keymap("n", "<leader>mt", 'vf|?[^ ]<cr>"tymT<leader>e/^translations.json$<cr><cr>G?{<cr>V%YP%A,<esc>2j$hhvi""tPjhdi"jdi":w<cr>\'T', { noremap = false })
vim.api.nvim_set_keymap("n", "<leader>mu", '-/^translations.json$<cr><cr>G?{<cr>V%YP%a,<esc>2j$hhvi""tPjhdi"jdi":w<cr>\'T', { noremap = false })
-- check translation
vim.api.nvim_set_keymap("n", "<leader>mc", 'vf|?[^ ]<cr>"tymT<leader>re"<c-r>t"', { noremap = false })

-- tabularize pipes in cucumber file
-- vim.keymap.set("n", "<leader>mp", "mt{/Examples:<cr>/|<cr>V}:Tabularize /|<CR>'t", { noremap = false })

-- replace dashes with space in current line
vim.keymap.set("n", "<leader>sc", ":silent s/-/ /g<CR>", { noremap = false })

-- format json from clipboard to clipboard
vim.keymap.set("n", "<leader>sj", ":silent !pbpaste | jq | pbcopy<CR>")
vim.keymap.set("n", "<leader>sx", ":silent !pbpaste | xmllint --format - | pbcopy<CR>")

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

vim.keymap.set("n", "<leader>sk", function()
    jump_to_log_line("~/dev/koios/rust/koios")
end, { desc = "jump to koios file and line found in current .log line"})

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

vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- substitute current word throughout file
vim.keymap.set("n", "<leader>su", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- shell commands
vim.keymap.set("n", "<leader>sp", ":!echo % | pbcopy<CR>", { noremap = true })
-- vim.keymap.set("n", "<leader>sx", "<cmd>!chmod +x %<CR>", { silent = true })

-- misc
vim.keymap.set("n", "Y", "yy")
-- vim.keymap.set("n", ":W<CR>", ":w<CR>")
-- vim.keymap.set("n", ":Wq<CR>", ":wq<CR>")
-- vim.keymap.set("n", ":Q", ":q")
-- vim.keymap.set("n", ":Qa", ":qa")

vim.keymap.set("n", "<leader>w", ":w<cr>")
-- vim.keymap.set("n", "<leader>a", "ggVG")

vim.keymap.set("i", "<s-tab>", "<c-d>")

-- vim.keymap.set("n", "<leader>d", ":cd %:h<CR>")

-- create a new file if it doesn't exist
vim.keymap.set("n", "<C-w>f", ":execute 'split ' . expand(\"<cfile>\")<CR>")
vim.keymap.set("n", "gf", ":execute 'edit ' . expand(\"<cfile>\")<CR>")

-- repeatable next and dot command
vim.keymap.set("n", "Q", ":normal n.<CR>")
-- repeat macro over visual block
vim.keymap.set("x", "q", ":normal @q<CR>")

-- open common files
vim.keymap.set("n", "<leader>os", ":e ~/scratch.txt<cr>")
vim.keymap.set("n", "<leader>od", ":e ~/did.txt<cr>")
-- vim.keymap.set("n", "<leader>ob", ":e ~/.bashrc<cr>")
-- vim.keymap.set("n", "<leader>obl", ":e ~/.bashrc-local<cr>")
-- vim.keymap.set("n", "<leader>oz", ":e ~/.zshrc<cr>")
vim.keymap.set("n", "<leader>ol", ":e ~/.zshrc-local<cr>")
-- vim.keymap.set("n", "<leader>on", ":new<cr>")
vim.keymap.set("n", "<leader>oo", ":e ~/temp/out.txt<cr>")
vim.keymap.set("n", "<leader>op", ":e ~/rust_playground/src/main.rs<cr>")
-- vim.keymap.set("n", "<leader>ot", ":e ~/.config/tmux/tmux.conf<cr>")
vim.keymap.set("n", "<leader>ot", ":e ~/.config/tmux-sessions.txt<cr>")

-- repeat dot command over a range
vim.keymap.set("x", ".", ":normal .<cr>")

-- run macro in register q over a range
vim.keymap.set("v", "<leader>q", ":norm! @q<Enter>")

-- stop auto-inserting comments
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

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
vim.api.nvim_set_keymap("n", "<leader>dd", ":lua Diddate()<CR>", { noremap = true })

-- fix :terminal for windows
-- vim.cmd('set shell=C:/Progra~1/Git/usr/bin/bash.exe')

-- next/prev quickfix items
vim.api.nvim_set_keymap("n", "<c-f>", ":cnext<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<c-b>", ":cprev<CR>", { noremap = true })

-- next/prev quickfix lists
vim.api.nvim_set_keymap("n", "]q", ":cnewer<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "[q", ":colder<CR>", { noremap = true })

vim.api.nvim_set_keymap("n", "]r", "/^}$<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "[r", "?^}$<cr>", { noremap = true })

vim.api.nvim_set_keymap("n", "]t", ":tabnext<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "[t", ":tabprev<CR>", { noremap = true })

-- lspconfig is changing colors of code, so let's disable that. From https://vi.stackexchange.com/questions/43428/how-to-disable-lsp-server-syntax-highlighting
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        client.server_capabilities.semanticTokensProvider = nil
    end,
});

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

vim.api.nvim_set_keymap('n', '<leader>cb', ':lua Cargo_build_in_tmux_pane()<CR>', { noremap = true, silent = true, desc = "cargo build current project" })

function Search_and_open_in_qf()
    local term = vim.fn.input('Search for: ')
    vim.cmd('vimgrep /' .. term .. '/ % | copen')
end
vim.api.nvim_set_keymap('n', '<leader>tc', ':lua Search_and_open_in_qf()<CR>', { noremap = true, silent = true, desc = "search buffer and send to qf" })

-- shortcut to default register in insert mode
vim.keymap.set("i", '<c-r><c-r>', '<c-r>"')
vim.keymap.set("i", '<c-r>r', '<c-r>"')

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
            vim.cmd('silent! split ' .. scratch_file)
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
            vim.cmd('split | buffer ' .. buf)
            vim.cmd('resize 15')
        end
    end
    Go_to_last_edit()
end

vim.api.nvim_set_keymap('n', '[s', ':lua Toggle_scratch(false)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']s', ':lua Toggle_scratch(true)<CR>', { noremap = true, silent = true })

