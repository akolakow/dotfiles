-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- add your plugins here
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
          "clangd"
        },
      },
    },
    {
      "neovim/nvim-lspconfig",
      config = function()
        local on_attach = function(client, bufnr)
          local opts = { noremap = true }
          vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>FzfLua lsp_references<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>FzfLua lsp_code_actions<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cd', '<cmd>FzfLua diagnostics_document<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cf', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
        end
        local lspconfig = require("lspconfig")
        lspconfig.lua_ls.setup({ on_attach = on_attach })
        lspconfig.pyright.setup({ on_attach = on_attach })
        lspconfig.ts_ls.setup({ on_attach = on_attach })
        lspconfig.rust_analyzer.setup({ on_attach = on_attach })
        lspconfig.clangd.setup({ on_attach = on_attach })
      end
    },
    {
      "ibhagwan/fzf-lua",
      -- optional for icon support
      dependencies = { "nvim-tree/nvim-web-devicons" },
      -- or if using mini.icons/mini.nvim
      -- dependencies = { "echasnovski/mini.icons" },
      opts = {}
    },
    { "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opt = {} },
    {
      'saghen/blink.cmp',
      -- optional: provides snippets for the snippet source
      dependencies = { 'rafamadriz/friendly-snippets', 'Kaiser-Yang/blink-cmp-avante', },

      -- use a release tag to download pre-built binaries
      version = '1.*',
      -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
      -- build = 'cargo build --release',
      -- If you use nix, you can build from source using latest nightly rust with:
      -- build = 'nix run .#build-plugin',

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
        completion = { documentation = { auto_show = true } },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
          default = { 'avante', 'lsp', 'path', 'snippets', 'buffer' },
          providers = {
            avante = {
              module = 'blink-cmp-avante',
              name = 'Avante',
              opts = {
                -- options for blink-cmp-avante
              }
            }
          },
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
    {
      "yetone/avante.nvim",
      event = "VeryLazy",
      version = false, -- Never set this value to "*"! Never!
      opts = {
        -- add any opts here
        -- for example
        provider = "ollama",
        providers = {
          ollama = {
            endpoint = "http://127.0.0.1:11434", -- Note that there is no /v1 at the end.
            model = "codegemma:2b",
          },
        },
      },
      -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
      build = "make",
      -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        -- "echasnovski/mini.pick", -- for file_selector provider mini.pick
        -- "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
        -- "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
        -- "ibhagwan/fzf-lua", -- for file_selector provider fzf
        -- "stevearc/dressing.nvim", -- for input provider dressing
        -- "folke/snacks.nvim", -- for input provider snacks
        -- "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        -- "zbirenbaum/copilot.lua", -- for providers='copilot'
        {
          -- support for image pasting
          "HakonHarnes/img-clip.nvim",
          event = "VeryLazy",
          opts = {
            -- recommended settings
            default = {
              embed_image_as_base64 = false,
              prompt_for_file_name = false,
              drag_and_drop = {
                insert_mode = true,
              },
              -- required for Windows users
              use_absolute_path = true,
            },
          },
        },
        {
          -- Make sure to set this up properly if you have lazy=true
          'MeanderingProgrammer/render-markdown.nvim',
          opts = {
            file_types = { "markdown", "Avante" },
          },
          ft = { "markdown", "Avante" },
        },
      },
    },
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
      },
      lazy = false, -- neo-tree will lazily load itself
      ---@module "neo-tree"
      ---@type neotree.Config?
      opts = {
        -- fill any relevant options here
        window = {
          mappings = {
            ["A"] = {
              "add_directory",
              config = {
                show_path = "absolute", -- "none", "relative", "absolute"
              },
            },
            ["a"] = {
              "add",
              config = {
                show_path = "absolute", -- "none", "relative", "absolute"
              },
            },
            ["c"] = {
              "copy",
              config = {
                show_path = "absolute", -- "none", "relative", "absolute"
              },
            },
            ["m"] = {
              "move",
              config = {
                show_path = "absolute", -- "none", "relative", "absolute"
              },
            },
          },
        },
      },
    },
    { "lewis6991/gitsigns.nvim" },
    {
      'numToStr/Comment.nvim',
      opts = {
        -- add any options here
      }
    },
    { "tpope/vim-surround" },

    { "ThePrimeagen/refactoring.nvim" },

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
      "vim-airline/vim-airline",
      dependencies = { "vim-airline/vim-airline-themes" },
      config = function()
        vim.cmd([[let g:airline_theme='base16_gruvbox_dark_soft']])
      end,
    },
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      lazy = false,
      enabled = true,
      config = function()
        textobjectss = {
              swap = {
                enable = true,
                swap_next = {
                  ["<leader>a"] = "@parameter.inner",
                },
                swap_previous = {
                  ["<leader>A"] = "@parameter.inner",
                },
              },
              select = {
                enable = true,

                -- Automatically jump forward to textobj, similar to targets.vim
                lookahead = true,

                keymaps = {
                  -- You can use the capture groups defined in textobjects.scm
                  ["af"] = "@function.outer",
                  ["if"] = "@function.inner",
                  ["ac"] = "@class.outer",
                  -- You can optionally set descriptions to the mappings (used in the desc parameter of
                  -- nvim_buf_set_keymap) which plugins like which-key display
                  ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                  -- You can also use captures from other query groups like `locals.scm`
                  ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
                },
                -- You can choose the select mode (default is charwise 'v')
                --
                -- Can also be a function which gets passed a table with the keys
                -- * query_string: eg '@function.inner'
                -- * method: eg 'v' or 'o'
                -- and should return the mode ('v', 'V', or '<c-v>') or a table
                -- mapping query_strings to modes.
                selection_modes = {
                  ['@parameter.outer'] = 'v', -- charwise
                  ['@function.outer'] = 'V',  -- linewise
                  ['@class.outer'] = '<c-v>', -- blockwise
                },
                -- If you set this to `true` (default is `false`) then any textobject is
                -- extended to include preceding or succeeding whitespace. Succeeding
                -- whitespace has priority in order to act similarly to eg the built-in
                -- `ap`.
                --
                -- Can also be a function which gets passed a table with the keys
                -- * query_string: eg '@function.inner'
                -- * selection_mode: eg 'v'
                -- and should return true or false
                include_surrounding_whitespace = true,
              },
              move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                  ["]m"] = "@function.outer",
                  ["]]"] = { query = "@class.outer", desc = "Next class start" },
                },
                goto_next_end = {
                  ["]M"] = "@function.outer",
                  ["]["] = "@class.outer",
                },
                goto_previous_start = {
                  ["[m"] = "@function.outer",
                  ["[["] = "@class.outer",
                },
                goto_previous_end = {
                  ["[M"] = "@function.outer",
                  ["[]"] = "@class.outer",
                },
                -- Below will go to either the start or the end, whichever is closer.
                -- Use if you want more granular movements
                -- Make it even more gradual by adding multiple queries and regex.
                -- goto_next = {
                --   ["]d"] = "@conditional.outer",
                -- },
                -- goto_previous = {
                --   ["[d"] = "@conditional.outer",
                -- }
              },
            },
            -- If treesitter is already loaded, we need to run config again for textobjects

            require("nvim-treesitter.configs").setup({ textobjects = textobjectss })
      end
    },
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      opts = {
        textobjects = {
          swap = {
            enable = true,
            swap_next = {
              ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>A"] = "@parameter.inner",
            },
          },
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              -- You can optionally set descriptions to the mappings (used in the desc parameter of
              -- nvim_buf_set_keymap) which plugins like which-key display
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
              -- You can also use captures from other query groups like `locals.scm`
              ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
            },
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
              ['@parameter.outer'] = 'v', -- charwise
              ['@function.outer'] = 'V',  -- linewise
              ['@class.outer'] = '<c-v>', -- blockwise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true or false
            include_surrounding_whitespace = true,
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = { query = "@class.outer", desc = "Next class start" },
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
            -- Below will go to either the start or the end, whichever is closer.
            -- Use if you want more granular movements
            -- Make it even more gradual by adding multiple queries and regex.
            -- goto_next = {
            --   ["]d"] = "@conditional.outer",
            -- },
            -- goto_previous = {
            --   ["[d"] = "@conditional.outer",
            -- }
          },
        },
      },
    },
    { "knsh14/vim-github-link" },
    {
      "danymat/neogen",
      config = true,
      -- Uncomment next line if you want to follow only stable versions
      -- version = "*"
    },
    {
      "ggandor/flit.nvim",
      config = function()
        require("flit").setup()
      end
    },
    {
      "ggandor/leap.nvim",
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
    { "tpope/vim-repeat" },
    {
      "ThePrimeagen/harpoon",
      branch = "harpoon2",
      dependencies = { "nvim-lua/plenary.nvim" }
    },
    { 'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons' },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

-- prevent the built-in vim.lsp.completion autotrigger from selecting the first item
vim.opt.completeopt = { "menuone", "noselect", "popup" }

vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])
-- vim.cmd([[colorscheme elflord]])

vim.api.nvim_set_keymap('n', '<leader><leader>', '<cmd>FzfLua files<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>/', '<cmd>FzfLua live_grep<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>bs', '<cmd>FzfLua buffers<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>Neotree toggle reveal<CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>gb', '<cmd>Gitsigns blame<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>ghp', '<cmd>Gitsigns preview_hunk<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>ghr', '<cmd>Gitsigns reset_hunk<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>gd', '<cmd>Gitsigns diffthis HEAD<CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>l', '<cmd>Lazy<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>gl', '<cmd>GetCurrentBranchLink<CR>', { noremap = true })


vim.wo.number = true

vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2

vim.api.nvim_set_option("clipboard", "unnamed")

local harpoon = require("harpoon")

-- harpoon
-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-j>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-k>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-l>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-;>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
-- vim.keymap.set("n", "<C-S-J>", function() harpoon:list():prev() end)
-- vim.keymap.set("n", "<C-S-K>", function() harpoon:list():next() end)

-- harpoon end


-- vim.opt.termguicolors = true
require("bufferline").setup{}
vim.api.nvim_set_keymap('n', '<C-S-Down>', '<cmd>BufferLineCyclePrev<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-S-Up>', '<cmd>BufferLineCycleNex<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>bo', '<cmd>BufferLineCloseOthers<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>bd', '<cmd>bd<CR>', { noremap = true })
