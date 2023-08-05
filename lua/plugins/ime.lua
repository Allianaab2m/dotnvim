return {
	"vim-skk/skkeleton",
	event = "InsertEnter",
	config = function()
		require("denops-lazy").load("skkeleton")
		vim.keymap.set("i", "<C-j>", "<Plug>(skkeleton-toggle)")
		vim.fn["skkeleton#config"]({
			eggLikeNewline = true,
		})
	end,
}
