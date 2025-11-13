vim = vim  -- so that we only get one info message here, instead of warnings everywhere else about the vim variable

vim.g.mapleader = " "

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

-- these don't work well with snacks->scroll
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<c-t>", "<nop>")

vim.keymap.set({"n", "v"}, "<leader>d", [["+d]])

---- end of primeagen mappings

---- macros

-- get the jira story from the commit template
vim.api.nvim_set_keymap("n", "<leader>ms", "/# On branch<CR>3WvEyggO<c-r>\"<CR><esc>kf-;C: ", { noremap = true })

-- run the next test
vim.api.nvim_set_keymap("n", "<leader>mn", "u''j mi", { noremap = false })

-- remove @cj from buffer
vim.api.nvim_set_keymap("n", "<leader>mx", ":g/^\\s*@cj\\s*$/d<cr>:w<esc>", { noremap = false })

-- add translation
vim.keymap.set("n", "<leader>mt", function()
    local buffer_dir = vim.fn.expand('%:p:h')
    local file_path = buffer_dir .. "/translations.json"
    if vim.fn.filereadable(file_path) == 0 then
        file_path = buffer_dir .. "/../translations.json"
        if vim.fn.filereadable(file_path) == 0 then
            print("Error: translations.json not found")
            return
        end
    end

    -- remember where we are so we can come back
    local bufnr = vim.api.nvim_get_current_buf()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local line = vim.api.nvim_get_current_line()
    local col = cursor[2]

    -- find the next pipe after the cursor
    local pipe_col = line:find("|", col + 1)

    -- find the last non-space character before the pipe
    local end_col = pipe_col - 1
    while end_col > col and line:sub(end_col, end_col):match("%s") do
        end_col = end_col - 1
    end

    -- grab the text and put it in register t
    local selected_text = line:sub(col + 1, end_col)
    vim.fn.setreg('t', selected_text)

    -- open translations file
    vim.cmd("e " .. file_path)
    vim.defer_fn(function() -- gotta sleep a bit here
        -- go to bottom of file, find the last translation section
        vim.cmd("normal! G")
        vim.cmd("?{")

        -- select the translation block and copy/paste it, and add a trailing comma
        vim.cmd("normal! V%YP%A,")

        -- replace current en-us translation with the one we yanked from the feature file, and remove values for other languages
        vim.cmd("normal! 2j$hhvi\"\"tPjhdi\"jdi\"")

        -- save translations.json
        vim.cmd(":w")

        -- go back to original location
        vim.api.nvim_set_current_buf(bufnr)
        vim.api.nvim_win_set_cursor(0, cursor)
    end, 100) -- ms
end, { desc = "add utterance under cursor to translations file" })

-- check translation
vim.api.nvim_set_keymap("n", "<leader>mc", 'vf|?[^ ]<cr>"ty:let @/ = ""<cr>mT<leader>re"<c-r>t"', { noremap = false })

-- replace dashes with space in current line
vim.keymap.set("n", "<leader>sc", ":silent s/-/ /g<CR>", { noremap = false })

-- format json from clipboard to clipboard
vim.keymap.set("n", "<leader>fj", ":silent !pbpaste | jq | pbcopy<CR>")
vim.keymap.set("n", "<leader>fx", ":silent !pbpaste | xmllint --format - | pbcopy<CR>")

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
end, { desc = "jump to file and line found in current log (work) line"})

vim.keymap.set("n", "<leader>sj", ":set syntax=json<cr>", { desc = "set syntax=json" })

vim.keymap.set("n", "<leader>go", function()
    vim.cmd('GBrowse ' .. vim.fn.expand("<cword>"))
end, { desc = "open commit under cursor in browser" })

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

-- substitute current word throughout file
-- vim.keymap.set("n", "<leader>su", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- shell commands
vim.keymap.set("n", "<leader>sp", ":let @+=expand('%:.')<cr>", { noremap = true, desc = "copy current file path to clipboard" })
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
vim.keymap.set("n", "<C-w>f", ":execute 'split ' . expand(\"<cfile>\")<CR>:resize 15<CR>")
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
vim.api.nvim_set_keymap("n", "<c-n>", ":cnext<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<c-p>", ":cprev<CR>", { noremap = true })

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
  local cmd = 'tmux split-window -v -l 15 "cd ' .. path .. ' && cargo build --manifest-path Cargo.toml ; exec $SHELL"'
  vim.fn.system(cmd)
end

-- vim.api.nvim_set_keymap('n', '<leader>cb', ':lua Cargo_build_in_tmux_pane()<CR>', { noremap = true, silent = true, desc = "cargo build current project" })

-- did I ever use this?
-- function Search_and_open_in_qf()
--     local term = vim.fn.input('Search for: ')
--     vim.cmd('vimgrep /' .. term .. '/ % | copen')
-- end
-- vim.api.nvim_set_keymap('n', '<leader>tc', ':lua Search_and_open_in_qf()<CR>', { noremap = true, silent = true, desc = "search buffer and send to qf" })

-- shortcut to default register in insert mode
vim.keymap.set("i", '<c-r><c-r>', '<c-r>"')
vim.keymap.set("i", '<c-r>r', '<c-r>"')

-- Setup split window sizes
vim.opt.equalalways = false -- Disable automatic resizing of splits
vim.keymap.set("n", '<leader>ss', ':split | wincmd J | resize 15<cr>', { desc = "split a smaller window" })
vim.keymap.set("n", '<leader>sv', ':split | wincmd L | vertical resize 70<cr>', { desc = "split a smaller vertical window" })

-- toggle
vim.keymap.set("n", '<leader>tw', function()
    vim.wo.wrap = not vim.wo.wrap
    print("Wrap turned " .. (vim.wo.wrap and "on" or "off"))
end, { desc = "toggle wrap" })

-- search within visual selection, via https://www.reddit.com/r/neovim/comments/1k4efz8/comment/mo9nalp/
vim.keymap.set("x", "/", "<Esc>/\\%V")

-- select pasted text
vim.keymap.set("n", "<leader>gv", "`[v`]")

-- Surround visual selection with triple backticks
vim.keymap.set('v', '<leader>cb', 'c```<CR><C-r>"<CR>```<Esc>', {
  noremap = true,
  silent = true,
  desc = "Surround with code block"
})
