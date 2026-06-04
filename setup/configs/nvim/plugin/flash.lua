vim.pack.add {
  { src = 'https://github.com/folke/flash.nvim' },
}

require("flash").setup({
  labels = "asdfghjklqwertyuiopzxcvbnm",
  modes = {
    search = { enabled = false },
    char = { enabled = true },
  },
})

local flash = require("flash")
-- Manual keymap version of flash.nvim
vim.keymap.set({'n', 'x', 'o'}, 's', function() require("flash").jump() end, { desc = "Flash" })
vim.keymap.set({'n', 'x', 'o'}, '<leader>s', function() require("flash").treesitter() end, { desc = "Flash Treesitter" })
vim.keymap.set('o', 'r', function() require("flash").remote() end, { desc = "Remote Flash" })
vim.keymap.set({'n','o', 'x'}, '<leader>t', function() require("flash").treesitter_search() end, { desc = "Treesitter Search" })
vim.keymap.set('c', '<C-S-c>', function() require("flash").toggle() end, { desc = "Toggle Flash Search" })
vim.keymap.set({"n", "x", "o"}, "<c-space>", function()
  require("flash").treesitter({
    actions = {
      ["<c-space>"] = "next",
      ["<BS>"] = "prev"
    }
  })
end, { desc = "Treesitter incremental selection" })
