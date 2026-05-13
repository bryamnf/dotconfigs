-- Install plugins
vim.pack.add({
    "https://github.com/folke/trouble.nvim",
    -- icons (optional but recommended)
    "https://github.com/nvim-tree/nvim-web-devicons",
})

-- Configure
require("trouble").setup({})

-- Keymaps (Trouble v3 style)
local map = vim.keymap.set
map("n", "<leader>x", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
map("n", "<leader>q", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix (Trouble)" })

local config = require("fzf-lua.config")
