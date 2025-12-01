-- filepath: nvim/lua/plugins/yanky.lua
---@diagnostic disable: undefined-global

return {
  "gbprod/yanky.nvim",
  opts = {
    highlight = {
      on_put = false,
      on_yank = false,
      timer = 500,
    },
  },
  dependencies = { "folke/snacks.nvim" },
  keys = {
    {
      "<leader>p",
      function()
          Snacks.picker.yanky()
      end,
      mode = { "n", "x" },
      desc = "Open Yank History",
    },
  }
}
