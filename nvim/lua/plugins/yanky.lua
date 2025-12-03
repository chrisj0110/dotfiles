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
    ring = {
        -- Track deletes as well as yanks
        history = 100,
        storage = "shada",
        sync_with_numbered_registers = true,
        cancel_event = "update",
        -- Add deleted text to the yankring
        update_register_on_delete = true,
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
