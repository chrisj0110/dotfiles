require("mason").setup()
require("mason-lspconfig").setup()

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

require("mason-lspconfig").setup {
    -- note: pin specific versions like "rust_analyzer@2024-12-23"
    ensure_installed = { "lua_ls", "gopls", "pylsp", "rust_analyzer", "bashls", "yamlls", "jsonls", "marksman" },
    -- pyright doesn't work b/c it wants npm
}

-- After setting up mason-lspconfig you may set up servers via lspconfig
local lspconfig = require("lspconfig")
local util = require("lspconfig/util")

lspconfig.rust_analyzer.setup({
    settings = {
        ['rust-analyzer'] = {
            cargo = {
                noDefaultFeatures = true
            }
        }
    }
})

lspconfig.lua_ls.setup({})

lspconfig.gopls.setup({
    cmd = { "/opt/homebrew/bin/gopls" },
    filetypes = {"go", "gomod", "gowork", "gotmpl" },
    rootdir = util.root_pattern("go.work", "go.mod", ".git"),
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

-- TODO: try flake8, mypy, ruff. Try jose-elias-alvarez/null-ls.nvim for mypy? Try ruff and ruff-lsp
lspconfig.pylsp.setup({
	settings = {
		pylsp = {
			configurationSources = {"pycodestyle", "flake8"},
			plugins = {
				pycodestyle = {
					maxLineLength = 160
				},
				mypy = {
					live_mode = true
				}
			}
		}
	},
    capabilities = capabilities
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
    root_dir = util.root_pattern(".bashrc", ".bash_profile", ".zshrc", ".sh", ".git"),
    capabilities = capabilities,
})

lspconfig.yamlls.setup({
    settings = {
        yaml = {
            schemas = {
                -- Use the GitLab CI schema for .gitlab-ci.yml files
                ["https://json.schemastore.org/gitlab-ci.json"] = "/*.gitlab-ci.yml",
            },
        },
    },
    capabilities = capabilities,  -- Use your existing nvim-cmp capabilities
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.gitlab-ci*.{yml,yaml}",
  callback = function()
    vim.bo.filetype = "yaml.gitlab"
  end,
})

local servers = {
    gitlab_ci_ls = {
        cmd = { '/opt/homebrew/bin/gitlab-ci-ls' },
        init_options = {
            cache = '~/.cache/gitlab-ci-ls/',
            log_path = '~/.cache/gitlab-ci-ls/log/gitlab-ci-ls.log',
        },
    },
}

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
    'marksman',
    'gitlab-ci-ls',
})

require('mason-lspconfig').setup {
    handlers = {
        function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
        end,
    },
}

-- TJ's setup: https://www.youtube.com/watch?v=22mrSjknDHI
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append "c"

local lspkind = require('lspkind')
lspkind.init {}

cmp.setup({
    sources = {
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer" },
    },
    mapping = {
        ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-y>"] = cmp.mapping(
            cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
            },
            { "i", "c" }
        ),
    },
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
})

local ls = require("luasnip")
ls.config.set_config {
    history = false,
    updateevents = "TextChanged,TextChangedI",
}

vim.keymap.set({ "i", "s" }, "<c-l>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-h>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })


vim = vim

vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts) -- maybe map this to something else
        -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        -- vim.keymap.set('n', '<space>wl', function()
        --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        -- end, opts)
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<leader>vca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        -- vim.keymap.set('n', '<leader>lf', function()
        --     vim.lsp.buf.format { async = true }
        -- end, opts)
    end,
})

