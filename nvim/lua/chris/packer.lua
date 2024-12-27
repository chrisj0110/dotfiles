-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        -- or                            , branch = '0.1.x',
        requires = { { "nvim-lua/plenary.nvim" } },
    })

    use({"benfowler/telescope-luasnip.nvim"})

    -- use("Mofiqul/dracula.nvim")

    use { "catppuccin/nvim", as = "catppuccin" }

    use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
    -- use("nvim-treesitter/playground")
    use({
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
        requires = "nvim-treesitter/nvim-treesitter",
    })

    -- use("theprimeagen/harpoon")
    use {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { {"nvim-lua/plenary.nvim"} }
    }

    -- use("mbbill/undotree")
    use("tpope/vim-fugitive")

    use({
        "hrsh7th/nvim-cmp",
        "onsails/lspkind.nvim",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        -- "hrsh7th/cmp-vsnip",
        -- "hrsh7th/vim-vsnip",
        -- "hrsh7th/vim-vsnip-integ",
        -- "rafamadriz/friendly-snippets",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp", -- used?
    })

    use({ "echasnovski/mini.comment", branch = "stable" })

    -- use({ "akinsho/toggleterm.nvim", tag = "*" })

    use("natecraddock/workspaces.nvim")

    -- can be used to format on save, which might conflict with rust-analyzer, etc
    -- use("nvimtools/none-ls.nvim")

    -- autoformat for rust
    -- use({ "rust-lang/rust.vim" })

    -- use({
    --     "goolord/alpha-nvim",
    --     requires = { "nvim-tree/nvim-web-devicons" },
    -- })

    use({ "nvim-tree/nvim-web-devicons"  }) -- something needs this

    use({ "nvim-lualine/lualine.nvim" })

    use({ "lewis6991/gitsigns.nvim" })

    use({ "godlygeek/tabular" })

    use({
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!:).
        run = "make install_jsregexp"
    })

    -- use({
    --     "NeogitOrg/neogit",
    --     requires = { { "nvim-lua/plenary.nvim" } },
    -- })

    use({ "christoomey/vim-tmux-navigator" }) -- TODO: can map something to :TmuxNavigateLeft, etc

    -- slow startup-time and rarely used
    -- use({
    --     "princejoogie/dir-telescope.nvim",
    --     -- telescope.nvim is a required dependency
    --     requires = {"nvim-telescope/telescope.nvim"},
    --     config = function()
    --         require("dir-telescope").setup({
    --             -- these are the default options set
    --             hidden = true,
    --             no_ignore = false,
    --             show_preview = true,
    --         })
    --     end,
    -- })

    use({ "shumphrey/fugitive-gitlab.vim" })

    use({ "tpope/vim-surround" })

    use({ "sindrets/diffview.nvim" })

    use({ "stefandtw/quickfix-reflector.vim" })

    use({ "chrisj0110/gherkin-tweaks" })

    use({
        "kdheepak/lazygit.nvim",
        -- optional for floating window border decoration
        requires = {
            "nvim-lua/plenary.nvim",
        },
    })

end)
