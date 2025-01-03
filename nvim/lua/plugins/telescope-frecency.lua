return {
  "nvim-telescope/telescope-frecency.nvim",
  -- install the latest stable version
  version = "*",
  config = function()
    require("telescope").load_extension "frecency"

    vim.keymap.set('n', '<C-p>', function()
        vim.cmd(':Telescope frecency workspace=CWD')
    end, { desc = "open file in current workspace based on frecency" }) -- just local files
  end,
}
