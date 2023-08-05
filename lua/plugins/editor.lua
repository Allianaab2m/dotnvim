return {
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = true,
	},
	{
		"cohama/lexima.vim",
		event = "InsertEnter",
	},
	{
		"phaazon/hop.nvim",
		lazy = false,
		opts = true,
		dependencies = {
			dir = "~/ghq/github.com/Allianaab2m/hop_kensaku",
			lazy = false,
			dependencies = {
				"lambdalisue/kensaku.vim",
			},
		},
		config = function()
			local hop = require("hop")
			local directions = require("hop.hint").HintDirection
			vim.keymap.set("", "f", function()
				hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
			end, { remap = true })
			vim.keymap.set("", "F", function()
				hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
			end, { remap = true })
			vim.keymap.set("", "t", function()
				hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
			end, { remap = true })
			vim.keymap.set("", "T", function()
				hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
			end, { remap = true })
			hop.setup()
		end,
	},
	{
		"yuki-yano/fuzzy-motion.vim",
		dependencies = {
			"vim-denops/denops.vim",
			"lambdalisue/kensaku.vim",
			"yuki-yano/denops-lazy.nvim",
		},
		cmd = "FuzzyMotion",
		init = function()
			vim.g.fuzzy_motion_matchers = { "fzf", "kensaku" }
			vim.keymap.set("", "<Leader>f", "<Cmd>FuzzyMotion<CR>", { silent = true, remap = true })
		end,
		config = function()
			require("denops-lazy").load("fuzzy-motion.vim", { wait_load = false })
			vim.cmd([[highlight FuzzyMotionShade guifg=#535C6A]])
			vim.cmd([[highlight FuzzyMotionChar guifg=#D38AEA]])
			vim.cmd([[highlight FuzzyMotionMatch guifg=#A0C980]])
			vim.cmd([[highlight FuzzyMotionSubChar guifg=#6CB6EB]])
		end,
	},
}
