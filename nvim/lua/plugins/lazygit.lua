return {
  "kdheepak/lazygit.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    -- Map <leader>gg to open LazyGit in the current working directory (cwd)
    -- I want gG to be gg, and I don't need the original gg:
    { "<leader>gg", function() require("lazygit").lazygit(vim.fn.getcwd()) end, desc = "LazyGit (cwd) [remapped]" },
    { "<leader>gG", false },
  },
}

