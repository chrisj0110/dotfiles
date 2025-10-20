return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
        model = 'gpt-4.1',           -- AI model to use
        temperature = 0.1,           -- Lower = focused, higher = creative
        window = {
            layout = 'horizontal',       -- 'vertical', 'horizontal', 'float'
            width = 0.5,              -- 50% of screen width
        },
        auto_insert_mode = true,     -- Enter insert mode when opening
    },
    keys = {
      { "<leader>cc", "<cmd>CopilotChat<cr>", desc = "Open Copilot Chat" },
      { "<leader>cf", function()
          -- jump down to the next window
          vim.cmd("wincmd j")
          -- get the relative file path
          local filepath = vim.fn.expand("%:p")
          -- jump back to the original window
          vim.cmd("wincmd k")
          -- add file path context to copilot chat
          vim.api.nvim_put({ "", "#file:" .. filepath, "" }, 'c', true, true)
      end, desc = "Send file context to CopilotChat" }
    },
  },
}
