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
		keymap('n', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
		keymap('n', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
		keymap('n', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
		keymap('n', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
		keymap('n', '<C-s>h', [[<Cmd>wincmd s<CR>]], opts)
		keymap('n', '<C-s>v', [[<Cmd>wincmd v<CR>]], opts)
		keymap('n', '<C-o>', [[<Cmd>wincmd o<CR>]], opts)
		keymap('n', '<C-q>', [[<Cmd>wincmd q<CR>]], opts)
	end,
})
