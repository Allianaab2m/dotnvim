return {
  { "vim-denops/denops.vim", event = { "VeryLazy" } },
  {
    "yuki-yano/denops-lazy.nvim",
    lazy = false,
    opts = true
  },
  { "tani/vim-artemis" },
	{
		"lambdalisue/kensaku.vim",
		dependencies = {
			"vim-denops/denops.vim",
		},
		config = function()
			require("denops-lazy").load("kensaku.vim")
		end,
	},
  { "nvim-lua/plenary.nvim", lazy = false }
}
