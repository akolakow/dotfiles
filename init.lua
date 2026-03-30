vim.pack.add({
    'https://github.com/echasnovski/mini.files',
    'https://github.com/ibhagwan/fzf-lua',
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/ellisonleao/gruvbox.nvim',
    'https://github.com/lewis6991/gitsigns.nvim',
    'https://github.com/knsh14/vim-github-link',
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/nvim-treesitter/nvim-treesitter-context',
    'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1") },
    "https://github.com/github/copilot.vim",
    "https://github.com/mason-org/mason.nvim",
    'https://github.com/neovim/nvim-lspconfig'
})


vim.cmd.colorscheme('gruvbox')

require('mini.files').setup()
require("mason").setup()

require('nvim-treesitter').install { "javascript", "typescript", "c", "cpp", "python", "lua", "vimdoc", "rust" }
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'cpp', 'python' },
    callback = function() vim.treesitter.start() end,
})

require('blink.cmp').setup
{
    keymap = { preset = "enter" },
    signature = { enabled = true },
    completion = {
        documentation = { auto_show = true },
        menu = {
            draw = {
                columns = { { "kind" }, { "label", "label_description", gap = 1 } },
            },
        },
    },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
}

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
require("set")
require("remap")

-- tree-sitter textobjects
vim.keymap.set("n", "<leader>sa", function()
    require("nvim-treesitter-textobjects.swap").swap_next "@parameter.inner"
end)
vim.keymap.set("n", "<leader>sA", function()
    require("nvim-treesitter-textobjects.swap").swap_previous "@parameter.inner"
end)
vim.keymap.set({ "x", "o" }, "ia", function()
    require "nvim-treesitter-textobjects.select".select_textobject("@parameter.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "aa", function()
    require "nvim-treesitter-textobjects.select".select_textobject("@parameter.outer", "textobjects")
end)

-- treesitter-context
vim.keymap.set('n', '<leader>cc', '<cmd>TSContext toggle<CR>', { noremap = true })

-- gitsigns
vim.keymap.set('n', '<leader>gb', '<cmd>Gitsigns blame<CR>', { noremap = true })
vim.keymap.set('n', '<leader>ghp', '<cmd>Gitsigns preview_hunk<CR>', { noremap = true })
vim.keymap.set('n', '<leader>ghr', '<cmd>Gitsigns reset_hunk<CR>', { noremap = true })
vim.keymap.set('n', '<leader>gd', '<cmd>Gitsigns diffthis HEAD<CR>', { noremap = true })

-- github-link
vim.keymap.set('n', '<leader>gl', '<cmd>GetCurrentBranchLink<CR>', { noremap = true })

-- lsp
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local opts = { noremap = true, buffer = ev.buf }
        vim.keymap.set("n", "gd", function()
            vim.lsp.buf.definition()
            vim.cmd("normal! zz")
        end, opts)
        vim.keymap.set("n", "gr", "<cmd>FzfLua lsp_references<CR>", opts)
        vim.keymap.set("n", "<leader>ca", "<cmd>FzfLua lsp_code_actions<CR>", opts)
        vim.keymap.set("n", "<leader>cs", "<cmd>FzfLua lsp_live_workspace_symbols<CR>", opts)
        vim.keymap.set("n", "<leader>cbs", "<cmd>FzfLua lsp_document_symbols<CR>", opts)
        vim.keymap.set("n", "<leader>cd", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
        vim.keymap.set("n", "<leader>cf", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
        vim.keymap.set(
            "n",
            "<leader>ci",
            "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>",
            opts
        )

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
vim.lsp.enable('pyright')
vim.lsp.enable('marksman')
vim.lsp.enable('ts_ls')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('lua_ls')

vim.lsp.config("clangd", {
    cmd = {
        "clangd",
        "--enable-config",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--fallback-style=Chromium",
    },
})
vim.lsp.enable('clangd')
