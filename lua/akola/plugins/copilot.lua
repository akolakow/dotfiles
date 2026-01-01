return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken",
		opts = {
			mappings = {
				show_diff = {
					normal = "gdd",
				},
			},
			-- window = {
			-- 	layout = "float",
			-- 	width = 80, -- Fixed width in columns
			-- 	height = 20, -- Fixed height in rows
			-- 	border = "rounded", -- 'single', 'double', 'rounded', 'solid'
			-- 	title = "🤖 AI Assistant",
			-- 	zindex = 100, -- Ensure window stays on top
			-- },
			--
			-- headers = {
			-- 	user = "👤 You",
			-- 	assistant = "🤖 Copilot",
			-- 	tool = "🔧 Tool",
			-- },
			--
			-- separator = "━━",
			-- auto_fold = true, -- Automatically folds non-assistant messages
		},

		-- keys = {
		--     {
		--         '<leader>aq',
		--         function()
		--             local input = vim.fn.input 'Quick Chat: '
		--             if input ~= '' then
		--                 require('CopilotChat').ask(input)
		--             end
		--         end,
		--         desc = 'Quick Chat (CopilotChat)',
		--         mode = { 'n', 'v' },
		--     },
		-- },

		config = function(_, opts)
			vim.g.copilot_no_tab_map = true
			vim.keymap.set("i", "<S-Tab>", 'copilot#Accept("\\<S-Tab>")', { expr = true, replace_keycodes = false })

			require("CopilotChat").setup(opts)

			vim.keymap.set({ "n", "v" }, "<leader>aa", function()
				require("CopilotChat").toggle()
			end, { desc = "Quick Chat (CopilotChat)" })

			vim.keymap.set({ "n", "v" }, "<leader>aq", function()
				local input = vim.fn.input("Quick Chat: ")
				if input ~= "" then
					require("CopilotChat").ask(input)
				end
			end, { desc = "Quick Chat (CopilotChat)" })
		end,
	},
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
