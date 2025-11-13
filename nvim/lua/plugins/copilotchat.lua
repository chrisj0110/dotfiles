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
        auto_insert_mode = false,
    },
    mapping = {
        accept = false, -- Disable default <c-y> accept mapping
    },
    keys = {
      { "<leader>cc", "<cmd>CopilotChat<cr>", desc = "Open Copilot Chat" },
      { "<leader>cf", function()
          -- jump down so we can also run this from the chat window
          vim.cmd("wincmd j")
          -- get the relative file path
          local filepath = vim.fn.expand("%:p")
          -- jump back to the original window
          vim.cmd("wincmd k")
          -- add file path context to copilot chat
          vim.api.nvim_put({ "#file:" .. filepath, "", "", "" }, 'c', true, true)
        end, desc = "Send file context to CopilotChat"
      },
      { "<leader>ct", function()
          vim.api.nvim_put({ "", "```", "", "```" }, 'c', true, true)

          vim.defer_fn(function() -- gotta sleep a bit here
              vim.cmd("normal! k")
              vim.cmd("startinsert")
          end, 100) -- ms
        end, desc = "add code block"
      },
    },
  },
}
