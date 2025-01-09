vim = vim

vim.o.guicursor = "n:hor50-Cursor,i:ver25"  -- Horizontal bar in normal mode, vertical bar in insert mode

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- vim.opt.colorcolumn = "80"

vim.opt.cursorline = true

-- windows path handling?
-- vim.opt.shellslash = true

-- Preserve existing line ending on the last line
vim.opt.fixendofline = false

-- TJ's setup: https://www.youtube.com/watch?v=22mrSjknDHI
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append "c"
