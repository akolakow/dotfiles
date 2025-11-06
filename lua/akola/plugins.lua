return {
    {
        'echasnovski/mini.surround',
        version = "*",
        config = function()
            require('mini.surround').setup()
        end
    },
    {
        'echasnovski/mini.files',
        version = '*',
        config = function()
            require('mini.files').setup()
        end
    },
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            vim.keymap.set('n', '<leader><leader>', '<cmd>FzfLua files<CR>', { noremap = true })
            vim.keymap.set('n', '<leader>/', '<cmd>FzfLua live_grep<CR>', { noremap = true })
            vim.keymap.set('n', '<leader>bs', '<cmd>FzfLua buffers<CR>', { noremap = true })
        end
    },
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        -- config = true,
        config = function()
            vim.o.background = "dark"
            vim.cmd([[colorscheme gruvbox]])
            vim.g.is_bg_transparent = 0
            function ToggleTransparent()
                vim.g.is_bg_transparent = (vim.g.is_bg_transparent + 1) % 2
                vim.cmd([[colorscheme gruvbox]])
                if vim.g.is_bg_transparent == 1 then
                    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
                    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
                end
            end

            vim.keymap.set('n', '<leader>t', '<cmd>lua ToggleTransparent()<CR>', { noremap = true })
        end

    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            vim.keymap.set('n', '<leader>gb', '<cmd>Gitsigns blame<CR>', { noremap = true })
            vim.keymap.set('n', '<leader>ghp', '<cmd>Gitsigns preview_hunk<CR>', { noremap = true })
            vim.keymap.set('n', '<leader>ghr', '<cmd>Gitsigns reset_hunk<CR>', { noremap = true })
            vim.keymap.set('n', '<leader>gd', '<cmd>Gitsigns diffthis HEAD<CR>', { noremap = true })
        end
    },
    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
            "TmuxNavigatorProcessList",
        },
        keys = {
            { "<c-left>",  "<cmd>TmuxNavigateLeft<cr>" },
            { "<c-down>",  "<cmd>TmuxNavigateDown<cr>" },
            { "<c-up>",    "<cmd>TmuxNavigateUp<cr>" },
            { "<c-right>", "<cmd>TmuxNavigateRight<cr>" },
            { "<c-\\>",    "<cmd>TmuxNavigatePrevious<cr>" },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        lazy = false,
        config = function()
            require 'nvim-treesitter.configs'.setup {
                -- A list of parser names, or "all"
                ensure_installed = { "javascript", "typescript", "c", "cpp", "python", "lua", "vimdoc", "rust" },

                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                auto_install = true,

                highlight = {
                    -- `false` will disable the whole extension
                    enable = true,

                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = false,
                },
                incremental_selection = {
                    enable  = true,
                    keymaps = {
                        init_selection    = 'si',  -- start selection at node under cursor
                        node_incremental  = 'si',  -- grow to next parent node
                        scope_incremental = false, -- jump to next scope (function, class…)
                        node_decremental  = 'sI',  -- shrink selection
                    },
                },
            }
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            vim.keymap.set('n', '<leader>cc', '<cmd>TSContext toggle<CR>', { noremap = true })
        end
    },
    {
        "nvim-treesitter/playground",
        lazy = false,
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        lazy = false,
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require 'nvim-treesitter.configs'.setup {
                textobjects = {
                    select = {
                        enable = true,

                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,

                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["ia"] = "@parameter.inner",
                            ["aa"] = "@parameter.outer",
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>sa"] = "@parameter.inner",
                        },
                        swap_previous = {
                            ["<leader>sA"] = "@parameter.inner",
                        },
                    },
                },
            }
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-refactor",
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require 'nvim-treesitter.configs'.setup {
                refactor = {
                    highlight_definitions = {
                        enable = true,
                        -- Set to false if you have an `updatetime` of ~100.
                        clear_on_cursor_move = true,
                    },
                },
            }
        end
    },
    {
        "knsh14/vim-github-link",
        config = function()
            vim.keymap.set('n', '<leader>gl', '<cmd>GetCurrentBranchLink<CR>', { noremap = true })
        end
    },
    {
        "danymat/neogen",
        config = true,
        -- Uncomment next line if you want to follow only stable versions
        -- version = "*"
    },
    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set('n', '<leader>u', '<cmd>UndotreeToggle<CR>', { noremap = true })
        end
    },
}
