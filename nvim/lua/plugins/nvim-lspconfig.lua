return {
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    {
        "neovim/nvim-lspconfig",
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
                    "rust_analyzer",
                    "yamlls",
                },
            }

            local lspconfig = require('lspconfig')
            local util = require("lspconfig/util")
            local capabilities = require('blink.cmp').get_lsp_capabilities()

            lspconfig.rust_analyzer.setup {
                capabilities = capabilities,
                settings = {
                    ['rust-analyzer'] = {
                        cargo = {
                            noDefaultFeatures = true
                        }
                    }
                }
            }

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
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
                            ["https://json.schemastore.org/gitlab-ci.json"] = "/*.gitlab-ci.yml",
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
            vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })

        end
    }
}
