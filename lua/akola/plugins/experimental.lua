return {
    { "tpope/vim-surround" },
    { "ThePrimeagen/refactoring.nvim" },
    {
        "ggandor/flit.nvim",
        enabled = false,
        config = function()
            require("flit").setup()
        end
    },
    {
        "ggandor/leap.nvim",
        enabled = false,
        config = function(_, opts)
            local leap = require("leap")
            leap.set_default_mappings()
            leap.opts.preview_filter =
                function(ch0, ch1, ch2)
                    return not (
                        ch1:match('%s') or
                        ch0:match('%a') and ch1:match('%a') and ch2:match('%a')
                    )
                end
        end,
    },
    {
        "tpope/vim-repeat",
        enabled = false,
    },

}
