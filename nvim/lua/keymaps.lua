local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Explore
keymap({ 'n', 'v' }, 'q', ':Ex<CR>', opts)

-- Cursor movements
keymap({ 'n', 'v', 'o' }, "<leader>l", "$", opts)  -- End of line
keymap({ 'n', 'v', 'o' }, "<leader>h", "^", opts)  -- Beginning of line
keymap({ 'n', 'v', 'o' }, "<leader>k", "gg", opts) -- Top of file
keymap({ 'n', 'v', 'o' }, "<leader>j", "G", opts)  -- Bottom of file

-- Clipboard
keymap('v', '<leader>y', '"+y')
keymap({ 'n', 'v' }, '<leader>p', '"+p', opts)

-- better up/down
keymap({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
keymap({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
keymap({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
keymap({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
