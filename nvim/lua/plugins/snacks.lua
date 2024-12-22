return {
  "folke/snacks.nvim",
  config = function()
    require("snacks").setup({
      opts = {
        statuscolumn = { enabled = false },
      },
    })
  end,
}
