vim.keymap.set("n", "[c", function()
  require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })

vim.api.nvim_set_hl(0, "TreesitterContextLineNumberBottom", {
  underline = true,  -- Set underline to true
  fg = "Grey",       -- Set the foreground color to Grey
})

