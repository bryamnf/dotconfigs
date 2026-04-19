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
keymap('n','<leader><leader>', function() vim.cmd('lsp enable') print("LSP enabled!") end)

-- Enable fzf
keymap("n","<C-f>", function()
  vim.fn.feedkeys(":FzfLua ", "n")
end, { desc = "FzfLua cmdline" })
keymap("n","<leader>f", function() vim.cmd('FzfLua files')end)
keymap("n","<leader>b", function() vim.cmd('FzfLua builtin')end)
keymap("n","<leader>g", function() vim.cmd('FzfLua live_grep')end)
