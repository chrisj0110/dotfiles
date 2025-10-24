return {
  "folke/snacks.nvim",
  event = "VeryLazy",
  opts = {
    picker = {
      matcher = {
          frecency = true,
          history_bonus = true,
      },
      sources = {
          -- https://github.com/folke/snacks.nvim/discussions/605#discussioncomment-11875984
          git_branches = {
              actions = {
                  copy_branch_name = function(picker, item)
                      vim.notify("Copied " .. item.branch .. " to clipboard")
                      vim.fn.setreg("+", item.branch)
                      picker:close()
                      -- print(vim.inspect(item))
                  end
              },
              win = {
                  input = {
                      keys = {
                          ["<c-c>"] = { "copy_branch_name", mode = { "i", "n" } },
                      },
                  },
              },
          },
          git_log = {
              confirm = function(picker, item)
                  vim.notify("Copied " .. item.commit .. " to clipboard")
                  vim.fn.setreg("+", item.commit)
                  picker:close()
              end,
          },
          git_log_file = {
              confirm = function(picker, item)
                  vim.notify("Copied " .. item.commit .. " to clipboard")
                  vim.fn.setreg("+", item.commit)
                  picker:close()
              end,
          },
      },
      -- have to copy an entire layout apparently: https://github.com/folke/snacks.nvim/discussions/468
      layouts = {
          default = {
              layout = {
                  box = "horizontal",
                  width = 0.95,
                  min_width = 120,
                  height = 0.95,
                  {
                      box = "vertical",
                      border = "rounded",
                      title = "{title} {live} {flags}",
                      { win = "input", height = 1, border = "bottom" },
                      { win = "list", border = "none" },
                  },
                  { win = "preview", title = "{preview}", border = "rounded", width = 0.5 },
              },
          },
      },
    }
  },
  keys = {
      { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
      { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
      -- find
      { "<leader>ft", function() Snacks.picker.files({ cwd = "~/til" }) end, desc = "Find TIL File" },
      { "<leader>fr", function() Snacks.picker.recent({ filter = { paths = { [vim.fn.getcwd()] = true, } } }) end, desc = "Recent" },
      -- git
      { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
      { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
      { "<leader>gD", function() Snacks.picker.git_diff({ base = "master" }) end, desc = "Git Diff (Hunks)" },
      { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
      { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
      { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
      { "<leader>gB", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
      -- grep
      { "<leader>/", function() Snacks.picker.grep({ hidden = true }) end, desc = "Grep" },
      { "<leader>sg", function()
          vim.ui.input({ prompt = "Enter file glob: " }, function(glob)
              if glob then
                  Snacks.picker.grep({ glob = glob, hidden = true })
              end
          end)
      end, desc = "Grep in file pattern" },
      { "<leader>st", function() Snacks.picker.grep({ dirs = { "~/til" }, hidden = true }) end, desc = "Grep TIL" },
      { "<leader>sw", function() Snacks.picker.grep_word({ hidden = true }) end, desc = "Visual selection or word", mode = { "n", "x" } },
      -- search
      { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
      { '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
      { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
      { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
      { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
      { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
      { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
      { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
      -- LSP
      { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
      -- TODO: handling luasnip with telescope-luasnip until/unless snacks supports it
  },
}
