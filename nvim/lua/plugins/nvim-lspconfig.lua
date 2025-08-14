return {
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim", version = "^1.0" }, -- 2.0 requires neovim 0.11.0
    {
        "neovim/nvim-lspconfig",
        version = "~2.0.0", -- 2.1 requires neovim 0.11.0
        lazy = true,
        event = { "FileType rust", "FileType sh", "FileType cucumber", "FileType lua", "FileType go", "FileType yaml", "FileType python", "FileType markdown" },
        dependencies = { 'saghen/blink.cmp' },
        config = function()
            require("mason").setup({})
            require("mason-lspconfig").setup {
                -- note: pin specific versions like "rust_analyzer@2024-12-23"
                ensure_installed = {
                    "bashls",
                    "cucumber_language_server",
                    "gitlab_ci_ls",
                    "gopls",
                    "jsonls",
                    "lua_ls",
                    "marksman",
                    "pylsp",
                    "rust_analyzer",
                    "yamlls",
                },
            }

            local lspconfig = require('lspconfig')
            local util = require("lspconfig/util")
            local capabilities = require('blink.cmp').get_lsp_capabilities()

            -- rust config
            local settings = {
                ['rust-analyzer'] = {
                    checkOnSave = true,
                    check = {
                        command = "clippy",
                    },
                    cargo = {
                        -- allFeatures = true, -- compile all feature-gated code
                        -- to fix "ERROR can't load standard library, try installing `rust-src` sysroot_path=...":
                        sysroot = vim.fn.expand("~/.rustup/toolchains/1.86.0-aarch64-apple-darwin"),
                        loadOutDirsFromCheck = false,
                        buildScripts = {
                            -- execute build.rs scripts for cfg attributes and macros; might slow things down?
                            enable = true,
                        },
                    },
                    rustc = {
                        source = "discover"
                    },
                    diagnostics = {
                        debounce = 150, -- to reduce frequent updates
                        disabled = {"macro-error"},
                    },
                    -- logging = {
                    --     level = "debug",  -- Set logging to debug for more insight
                    --     file = "rust-analyzer.log",  -- Specify a log file for diagnostics
                    -- },
                    cachePriming = {
                        enable = true -- Pre-loads caches for faster initial completions
                    },
                    files = {
                        excludeDirs = {
                            "outputs",
                            "bazel-out",
                            "bazel-p21-embedded"
                        },
                    },
                }
            }

            -- see also lazyvim rust-analyzer config: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/lang/rust.lua
            lspconfig.rust_analyzer.setup {
                -- cmd = { vim.fn.expand("~/.rustup/toolchains/1.78.0-aarch64-apple-darwin/bin/rust-analyzer") },
                -- cmd = { vim.fn.expand("~/.cargo/bin/rust-analyzer") },
                -- cmd = { "rustup", "run", "stable", "rust-analyzer" },
                -- cmd = { vim.fn.expand("~/.rustup/toolchains/stable-aarch64-apple-darwin/bin/rust-analyzer") },
                -- cmd = { vim.fn.expand("~/.local/bin/rust-analyzer") },
                -- cmd = { vim.fn.expand("~/.cargo/bin/rust-analyzer-wrapper") },
                cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/rust-analyzer") },
                capabilities = capabilities,
                settings = settings,
            }

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' }, -- Add 'vim' to the recognized globals
                            disable = { "redundant-assign" }, -- Ignore the redundant assignment warning
                        },
                    },
                },
            })

            lspconfig.gopls.setup({
                cmd = { "/opt/homebrew/bin/gopls" },
                filetypes = {"go", "gomod", "gowork", "gotmpl" },
                rootdir = util.root_pattern("go.work", "go.mod", ".git"),
                capabilities = capabilities,
                settings = {
                    gopls = {
                        completeUnimported = true,
                        usePlaceholders = true,
                        analyses = {
                            unusedparams = true,
                        },
                    },
                },
            })

            lspconfig.cucumber_language_server.setup({
                filetypes = { "cucumber", "feature" },
                root_dir = require("lspconfig.util").find_git_ancestor,
                settings = {},
                capabilities = capabilities,
                handlers = {
                ["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
                  if result and result.diagnostics then
                    local filtered_diagnostics = {}
                    for _, diagnostic in ipairs(result.diagnostics) do
                      if diagnostic.severity == vim.diagnostic.severity.ERROR then
                        table.insert(filtered_diagnostics, diagnostic)
                      end
                    end
                    result.diagnostics = filtered_diagnostics
                  end
                  vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
                end,
              },
            })

            lspconfig.bashls.setup({
                filetypes = { "sh", "bash", "zsh" },
                capabilities = capabilities,
                root_dir = util.root_pattern(".bashrc", ".bash_profile", ".zshrc", ".sh", ".git"),
            })

            lspconfig.yamlls.setup({
                capabilities = capabilities,
                settings = {
                    yaml = {
                        schemas = {
                            -- Use the GitLab CI schema for .gitlab-ci.yml files
                            ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "/*.gitlab-ci.yml",
                        },
                        customTags = {
                            -- not sure why `!reference` is being reported as an error
                            "!reference sequence"
                        }
                    },
                },
            })

            lspconfig.pylsp.setup({
                settings = {
                    pylsp = {
                        plugins = {
                            pycodestyle = {
                                ignore = {"E501"},
                            },
                        },
                    },
                },
            })

            lspconfig.marksman.setup({})

            vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
                pattern = "*.gitlab-ci*.{yml,yaml}",
                callback = function()
                    vim.bo.filetype = "yaml.gitlab"
                end,
            })

            -- workaround for https://github.com/neovim/neovim/issues/30985 where I was getting "rust_analyzer: -32802: server cancelled the request"
            for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
                local default_diagnostic_handler = vim.lsp.handlers[method]
                vim.lsp.handlers[method] = function(err, result, context, config)
                    if err ~= nil and err.code == -32802 then
                        return
                    end
                    return default_diagnostic_handler(err, result, context, config)
                end
            end

            vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
            -- vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '[e', ":lua vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })<CR>", { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', ']e', ":lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>", { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '[w', ":lua vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })<CR>", { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', ']w', ":lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })<CR>", { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '[h', ":lua vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.HINT })<CR>", { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', ']h', ":lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.HINT })<CR>", { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '[i', ":lua vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.INFO })<CR>", { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', ']i', ":lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.INFO })<CR>", { noremap = true, silent = true })

            -- vim.lsp.set_log_level("DEBUG")
        end
    }
}
