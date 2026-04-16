local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Explore
keymap({ 'n', 'v' }, 'q', ':Ex<CR>', opts)

-- Clipboard
keymap('v', '<leader>y', '"+y')
keymap({ 'n', 'v' }, '<leader>p', '"+p', opts)

-- better up/down
keymap({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
keymap({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
keymap({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
keymap({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Esc highlight mode
keymap({ 'i', 'n', 'v' }, '<Esc>', function()
  vim.cmd('nohlsearch')
  return '<Esc>'
end, { expr = true, desc = 'Escape and clear search highlight' })

-- Enable lsp
keymap('n','<leader>l', function() vim.cmd('lsp enable') print("LSP enabled!") end)

-- Enable fzf
vim.keymap.set("n","<leader><leader>", function()
  vim.fn.feedkeys(":FzfLua ", "n")
end, { desc = "FzfLua cmdline" })
