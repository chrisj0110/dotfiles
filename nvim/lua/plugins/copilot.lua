return {
  "github/copilot.vim",
  -- event = "VeryLazy",
  config = function()
    -- -- Disable automatic suggestions
    -- vim.g.copilot_no_tab_map = true
    -- vim.g.copilot_assume_mapped = true
    -- vim.g.copilot_enabled = true

    -- -- Disable automatic triggers
    -- vim.g.copilot_filetypes = {
    --   ["*"] = false,
    -- }

    -- -- Keymaps for manual control
    -- vim.keymap.set('i', '<C-]><C-]>', function()
    --     -- Create virtual text indicator
    --     local ns = vim.api.nvim_create_namespace("copilot_thinking")
    --     local bufnr = vim.api.nvim_get_current_buf()
    --     local row = vim.api.nvim_win_get_cursor(0)[1] - 1
    --
    --     vim.api.nvim_buf_set_extmark(bufnr, ns, row, 0, {
    --         virt_text = {{"🤖 thinking...", "Comment"}},
    --         virt_text_pos = "eol"
    --     })
    --
    --     -- get the suggestion
    --     vim.fn['copilot#Suggest']()
    --
    --     -- Clear the virtual text after delay
    --     vim.defer_fn(function()
    --         vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
    --     end, 2000)
    -- end, { desc = 'Request Copilot suggestion' })

    vim.keymap.set('i', '<C-]><C-y>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false
    })
    vim.g.copilot_no_tab_map = true

    vim.keymap.set('i', '<C-]><C-n>', function()
      -- Decline/dismiss the suggestion
      vim.fn['copilot#Dismiss']()
    end, { desc = 'Decline Copilot suggestion' })
  end
}
