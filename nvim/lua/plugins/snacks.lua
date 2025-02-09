return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      matcher = {
          frecency = true,
          history_bonus = true,
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
      { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
      -- find
      { "<leader>ft", function() Snacks.picker.files({ cwd = "~/til" }) end, desc = "Find TIL File" },
      { "<leader>fr", function() Snacks.picker.recent({ filter = { paths = { [vim.fn.getcwd()] = true, } } }) end, desc = "Recent" },
      -- git
      { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
      { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
      { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
      { "<leader>gB", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
      -- grep
      { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>sG", function()
          vim.ui.input({ prompt = "Enter file glob: " }, function(glob)
              if glob then
                  require("snacks").picker.grep({ glob = glob })
              end
          end)
      end, desc = "Grep in file pattern" },
      { "<leader>st", function() Snacks.picker.grep({ dirs = { "~/til" } }) end, desc = "Grep TIL" },
      { "<leader>gF", function() Snacks.picker.grep({ dirs = { require("gp").config.chat_dir } }) end, desc = "Grep GP Chat File" },
      { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
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
      -- TODO: handling luasnip with telescope until/unless snacks supports it
  },
}
