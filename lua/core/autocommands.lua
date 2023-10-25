local function augroup(name)
	return vim.api.nvim_create_augroup(name, { clear = true })
end

-- Auto create dir
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = augroup("auto_create_dir"),
	callback = function(event)
		if event.match:match("^%w%w+://") then
			return
		end
		local file = vim.loop.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- Auto organize import at Go lang
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
	end,
})

-- Disable relative number on insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
	callback = function(event)
		vim.opt.relativenumber = false
	end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
	callback = function(event)
		vim.opt.relativenumber = true
	end,
})
