return {
  'saghen/blink.cmp',
  event = "VeryLazy",

  -- optional: provides snippets for the snippet source
  -- dependencies = 'rafamadriz/friendly-snippets',

  -- use a release tag to download pre-built binaries
  version = '*',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  dependencies = { 'L3MON4D3/LuaSnip', version = 'v2.*' },
  opts = {
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    -- See the full "keymap" documentation for information on defining your own keymap.
    keymap = {
        preset = 'default',
    },

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- Will be removed in a future release
      use_nvim_cmp_as_default = true,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },

    snippets = { preset = 'luasnip' },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'buffer', 'lsp', 'path', 'snippets' },
      min_keyword_length = function(ctx)
        -- don't show autocomplete menu for commands until we have at least 2 chars
        -- .. so I can use up/down arrow to find MRU commands
        -- only applies when typing a command, doesn't apply to arguments
        if ctx.mode == 'cmdline' and string.find(ctx.line, ' ') == nil then return 2 end
        return 0
      end
    },
    cmdline = {
      sources = function() -- from https://cmp.saghen.dev/configuration/reference.html#completion-menu
        local type = vim.fn.getcmdtype()
        -- Search forward and backward
        if type == '/' or type == '?' then return { 'buffer' } end
        -- Commands
        if type == ':' or type == '@' then return { 'cmdline' } end
        return {}
      end,
    },
  },
  opts_extend = { "sources.default" }
}
