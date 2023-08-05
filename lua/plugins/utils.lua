return {
	{ "vim-denops/denops.vim", lazy = false },
	{
		"yuki-yano/denops-lazy.nvim",
	},
	{ "tani/vim-artemis" },
	{ "nvim-lua/plenary.nvim", lazy = false },
	{
		"m4xshen/hardtime.nvim",
		lazy = false,
		config = function()
			require("hardtime").setup({
				disabled_filetypes = { "qf", "netrw", "lazy", "mason", "oil", "toggleterm" },
			})
		end,
	},
}
