return {
    {
  "yetone/avante.nvim",
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  -- ⚠️ must add this setting! ! !
  build = vim.fn.has("win32") ~= 0
      and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  ---@module 'avante'
  ---@type avante.Config
  opts = {
    -- add any opts here
    -- this file can contain specific instructions for your project
    instructions_file = "avante.md",
    -- for example
    provider = "copilot",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    -- "nvim-mini/mini.pick", -- for file_selector provider mini.pick
    -- "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    -- "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    -- "stevearc/dressing.nvim", -- for input provider dressing
    -- "folke/snacks.nvim", -- for input provider snacks
    -- "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
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
	-- {
	-- 	"CopilotC-Nvim/CopilotChat.nvim",
	-- 	dependencies = {
	-- 		{ "nvim-lua/plenary.nvim", branch = "master" },
	-- 	},
	-- 	build = "make tiktoken",
	-- 	opts = {
	-- 		mappings = {
	-- 			show_diff = {
	-- 				normal = "gdd",
	-- 			},
	-- 		},
	-- 		-- window = {
	-- 		-- 	layout = "float",
	-- 		-- 	width = 80, -- Fixed width in columns
	-- 		-- 	height = 20, -- Fixed height in rows
	-- 		-- 	border = "rounded", -- 'single', 'double', 'rounded', 'solid'
	-- 		-- 	title = "🤖 AI Assistant",
	-- 		-- 	zindex = 100, -- Ensure window stays on top
	-- 		-- },
	-- 		--
	-- 		-- headers = {
	-- 		-- 	user = "👤 You",
	-- 		-- 	assistant = "🤖 Copilot",
	-- 		-- 	tool = "🔧 Tool",
	-- 		-- },
	-- 		--
	-- 		-- separator = "━━",
	-- 		-- auto_fold = true, -- Automatically folds non-assistant messages
	-- 	},
	--
	-- 	-- keys = {
	-- 	--     {
	-- 	--         '<leader>aq',
	-- 	--         function()
	-- 	--             local input = vim.fn.input 'Quick Chat: '
	-- 	--             if input ~= '' then
	-- 	--                 require('CopilotChat').ask(input)
	-- 	--             end
	-- 	--         end,
	-- 	--         desc = 'Quick Chat (CopilotChat)',
	-- 	--         mode = { 'n', 'v' },
	-- 	--     },
	-- 	-- },
	--
	-- 	config = function(_, opts)
	-- 		vim.g.copilot_no_tab_map = true
	-- 		vim.keymap.set("i", "<S-Tab>", 'copilot#Accept("\\<S-Tab>")', { expr = true, replace_keycodes = false })
	--
	-- 		require("CopilotChat").setup(opts)
	--
	-- 		vim.keymap.set({ "n", "v" }, "<leader>aa", function()
	-- 			require("CopilotChat").toggle()
	-- 		end, { desc = "Quick Chat (CopilotChat)" })
	--
	-- 		vim.keymap.set({ "n", "v" }, "<leader>aq", function()
	-- 			local input = vim.fn.input("Quick Chat: ")
	-- 			if input ~= "" then
	-- 				require("CopilotChat").ask(input)
	-- 			end
	-- 		end, { desc = "Quick Chat (CopilotChat)" })
	-- 	end,
	-- },
	{
		"github/copilot.vim",
		version = "*",

		config = function(_, opts)
			-- vim.cmd([[
			--                      let g:copilot_filetypes = {
			--                            \ '*': v:false,
			--                            \ 'cpp': v:true,
			--                            \ }
			--              ]])
		end,
	},

}
