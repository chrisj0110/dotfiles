-- Copilot configuration for manual suggestions only
return {
  "github/copilot.vim",
  -- event = "VeryLazy",
  config = function()
    -- Disable automatic suggestions
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    vim.g.copilot_enabled = true

    -- Disable automatic triggers
    vim.g.copilot_filetypes = {
      ["*"] = false,
    }

    -- Keymaps for manual control
    vim.keymap.set('i', '<C-]><C-]>', function()
      -- Manually request a suggestion
      vim.fn['copilot#Suggest']()
    end, { desc = 'Request Copilot suggestion' })

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
