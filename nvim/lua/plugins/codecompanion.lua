return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    opts = {
      log_level = "DEBUG", -- or "TRACE"
    },
  },
  config = function()
      vim.api.nvim_set_keymap('n', '<leader>cc', ":CodeCompanionChat Toggle<CR>", { noremap = true, silent = true })
  end,
}

