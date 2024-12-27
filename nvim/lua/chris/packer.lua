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

    use { "catppuccin/nvim", as = "catppuccin" }

    use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
    use({
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
        requires = "nvim-treesitter/nvim-treesitter",
    })

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

    use({ "nvim-tree/nvim-web-devicons"  }) -- something needs this

    use({ "nvim-lualine/lualine.nvim" })

    use({ "lewis6991/gitsigns.nvim" })

    use({
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!:).
        run = "make install_jsregexp"
    })

    use({ "christoomey/vim-tmux-navigator" }) -- TODO: can map something to :TmuxNavigateLeft, etc

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

    use({
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup()
        end,
    })

end)
