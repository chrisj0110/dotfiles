return {
  "sindrets/diffview.nvim",
  config = function()
    vim.keymap.set("n", "<leader>gC", function()
      local merge_base = vim.fn.systemlist("git merge-base HEAD master")[1]
      if not merge_base or merge_base == "" then
        vim.notify("Failed to get merge base between HEAD and master", vim.log.levels.ERROR)
        return
      end
      vim.cmd("tabfirst | tabonly")
      require('diffview').open(merge_base .. "..HEAD")
    end, { desc = "Open Diffview between HEAD and master" })
  end,
}
