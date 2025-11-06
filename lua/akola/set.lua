vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.g.netrw_browse_split = 4
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_liststyle = 3


vim.api.nvim_set_option("clipboard", "unnamed")

vim.g.markdown_folding = 1

-- Create autocommand to set mapping only for Markdown files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.keymap.set("n", "<Tab>", "za", { buffer = true, noremap = true, silent = true })
        vim.o.foldtext = ""

        vim.o.textwidth = 80
        -- vim.o.wrap = true
        -- vim.o.columns = 80
        -- vim.keymap.set("n", "j", "gj", { buffer = true, noremap = true, silent = true })
        -- vim.keymap.set("n", "k", "gk", { buffer = true, noremap = true, silent = true })
    end
})
