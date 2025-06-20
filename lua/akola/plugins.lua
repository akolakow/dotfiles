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
