local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Explore
keymap({ 'n', 'v' }, '<leader>q', ':Ex<CR>', opts)
-- In netrw, remap q to :qall!
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'netrw',
    callback = function()
        vim.keymap.set('n', '<leader>q', '<cmd>qall!<cr>', {
            buffer = true,
            silent = true,
            nowait = true,
            desc = 'Quit all from netrw',
        })
    end,
})
-- Vexplore
keymap({ 'n', 'v' }, '<leader>v', ':Vexplore<CR>', opts)

-- Clipboard
keymap('v', '<C-c>', '"+y')
keymap({ 'n', 'v' }, '<C-S-v>', '"+p', opts)

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
keymap('n', '<leader><leader>', function()
    vim.cmd('lsp enable')
    print("LSP enabled!")
end)

-- FzfLua
keymap("n", "<leader>f", function() vim.cmd('FzfLua files') end)
keymap("n", "<C-b>", function() vim.cmd('FzfLua builtin') end)
keymap("n", "<leader>g", function() vim.cmd('FzfLua live_grep') end)
keymap("n", "<C-l>", function()
    require("fzf-lua").builtin({ query = "lsp_" })
end, { desc = "FzfLua builtin (lsp_ prefilled)" })
