-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_augroup("CustomFormatOptions", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = "CustomFormatOptions",
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove("c") -- disable Automatically continue comments when pressing Enter in Insert mode
    vim.opt_local.formatoptions:remove("r") -- disable Automatically insert the current comment leader after hitting <Enter> in Insert mode.
    vim.opt_local.formatoptions:remove("o") -- disable Allow automatic continuation of comments when using the o or O commands.
  end,
})
