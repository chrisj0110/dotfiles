return {
  "akinsho/bufferline.nvim",
  config = function()
    require("bufferline").setup({
      options = {
        mode = "tabs",
        always_show_bufferline = false,
      },
    })
  end,
}
