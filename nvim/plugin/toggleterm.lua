vim.pack.add {
    { src = 'https://github.com/akinsho/toggleterm.nvim' },
}

-- In your toggleterm setup
require("toggleterm").setup({
  open_mapping = [[<c-\>]],   -- toggle from anywhere (including insert/terminal mode)
  direction = "tab",         -- or "horizontal" / "vertical"
  float_opts = { border = "curved" },
  shade_terminals = true,
  start_in_insert = true,
  persist_size = true,
  persist_mode = true,
})

-- Escape terminal mode easily
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])


local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<C-g>", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
