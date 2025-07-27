return {
    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require("null-ls")

            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.prettier.with({
                        filetypes = { "markdown" }, -- only use for markdown
                    }),
                },
            })
        end
    },
    {
        'mason-org/mason.nvim',
        opts = {},
    },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = { 'neovim/nvim-lspconfig' },
        opts = {
            ensure_installed = {
                "lua_ls",
                "pyright",
                "ts_ls",
                "rust_analyzer",
                "clangd", "marksman"
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(ev)
                    local opts = { noremap = true, buffer = ev.buf }
                    vim.keymap.set('n', 'gd', function()
                        vim.lsp.buf.definition()
                        vim.cmd("normal! zz")
                    end, opts)
                    vim.keymap.set('n', 'gr', '<cmd>FzfLua lsp_references<CR>', opts)
                    vim.keymap.set('n', '<leader>ca', '<cmd>FzfLua lsp_code_actions<CR>', opts)
                    vim.keymap.set('n', '<leader>cs', '<cmd>FzfLua lsp_live_workspace_symbols<CR>', opts)
                    vim.keymap.set('n', '<leader>cd', '<cmd>lua vim.diagnostic.open_float()<CR>',
                        opts)
                    vim.keymap.set('n', '<leader>cf', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
                    vim.keymap.set('n', '<leader>ci',
                        '<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>', opts)

                    -- vim.keymap.set('i', '<c-space>', function()
                    --     vim.lsp.completion.get()
                    -- end)

                    vim.diagnostic.config({
                        virtual_lines = {
                            -- Only show virtual line diagnostics for the current cursor line
                            current_line = true,
                        },
                    })
                    vim.opt.completeopt = { "menuone", "noselect", "popup" }
                end,
            })
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = { globals = { 'vim' } }
                    }
                }
            })
            lspconfig.pyright.setup({})
            lspconfig.ts_ls.setup({})
            lspconfig.marksman.setup({})
            lspconfig.rust_analyzer.setup({})
            lspconfig.clangd.setup({
                cmd = {
                    "clangd",
                    "--enable-config",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=iwyu",
                    "--completion-style=detailed",
                    "--function-arg-placeholders",
                    "--fallback-style=Chromium", }
            })
        end
    },
    {
        -- the only thing, which stops me from using native lsp completion
        -- is signature help, which requires cycling, which is broken
        'saghen/blink.cmp',
        enabled = true,
        -- optional: provides snippets for the snippet source
        dependencies = { 'rafamadriz/friendly-snippets', },

        -- use a release tag to download pre-built binaries
        version = '1.*',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
            -- 'super-tab' for mappings similar to vscode (tab to accept)
            -- 'enter' for enter to accept
            -- 'none' for no mappings
            --
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = { preset = 'enter' },
            signature = { enabled = true },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            -- (Default) Only show the documentation popup when manually triggered
            completion = {
                documentation = { auto_show = true },
                menu = {
                    draw = {
                        columns = { { 'kind' }, { 'label', 'label_description', gap = 1 } },
                    },
                },
            },


            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },

            -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
            -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
            -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
            --
            -- See the fuzzy documentation for more information
            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    },
}
