local keymap = vim.keymap.set

-- relative numbers in netrw
vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		vim.opt_local.relativenumber = true
		vim.opt_local.number = true
	end,
})
