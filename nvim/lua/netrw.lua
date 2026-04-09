local keymap = vim.keymap.set

-- relative numbers in netrw
vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		vim.opt_local.relativenumber = true
		vim.opt_local.number = true
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		local opts = { noremap = true, silent = true, buffer = true }
		keymap({ 'n', 'v' }, "<leader>l", "$", opts)
		keymap({ 'n', 'v' }, "<leader>h", "^", opts)
		keymap({ 'n', 'v' }, "<leader>k", "gg", opts)
		keymap({ 'n', 'v' }, "<leader>j", "G", opts)
	end,
})
