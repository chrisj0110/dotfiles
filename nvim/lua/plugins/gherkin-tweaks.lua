return {
  "chrisj0110/gherkin-tweaks",
  config = function()
    require("gherkin-tweaks").setup({
      tag = '@cj',
      auto_save = true,
    })
    vim.keymap.set('n', '<leader>mi',
      require('gherkin-tweaks').isolate_test,
      { desc = 'Isolate just this gherkin test' })

    vim.keymap.set('n', '<leader>ms',
      require('gherkin-tweaks').add_tag_to_section,
      { desc = 'Add tag to the top of the current gherkin section' })

    vim.keymap.set('n', '<leader>me',
      require('gherkin-tweaks').copy_table_header,
      { desc = 'Copy the previous gherkin table header above the current line' })

  end,
}
