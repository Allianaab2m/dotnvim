return {
	"vim-skk/skkeleton",
	event = "InsertEnter",
	config = function()
		require("denops-lazy").load("skkeleton")
		vim.keymap.set("i", "<C-j>", "<Plug>(skkeleton-toggle)")
		vim.fn["skkeleton#register_kanatable"]("rom", {
			[","] = { "，", "" },
			["."] = { "．", "" },
		})
		vim.fn["skkeleton#config"]({
			eggLikeNewline = true,
			globalDictionaries = {
				{ "/usr/share/skk/SKK-JISYO.L", "euc-jp" },
				"~/.skk/SKK-JISYO.emoji.utf8",
			},
		})
	end,
}
