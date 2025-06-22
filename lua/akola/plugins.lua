return {
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
        config = true,
        opt = {}
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
        opts = {
            -- A list of parser names, or "all"
            ensure_installed = { "help", "javascript", "typescript", "c", "cpp", "python", "lua", "rust" },

            -- Install parsers synchronously (only applied to `ensure_installed`)
            -- sync_install = false,

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
        },
    },
    { "nvim-treesitter/nvim-treesitter-context",
        config = function ()
            vim.keymap.set('n', '<leader>cc', '<cmd>TSContext toggle<CR>', { noremap = true })
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
