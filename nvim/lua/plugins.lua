local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- Basics
Plug('Mofiqul/vscode.nvim', { ['as'] = 'vscode' })
--Plug('ggandor/leap.nvim')
--Plug('akinsho/toggleterm.nvim', { ['tag'] = '*' })
--Plug('windwp/nvim-autopairs')

-- Syntax highlighting
--Plug("nvim-treesitter/nvim-treesitter", { ['do'] = ":TSUpdate" })
--Plug("nvim-treesitter/nvim-treesitter-context")
--Plug("nvim-treesitter/nvim-treesitter-textobjects")

-- Linting and Formating
--Plug('mfussenegger/nvim-lint')
--Plug("stevearc/conform.nvim")

-- Telescope
--Plug('nvim-lua/plenary.nvim')
--Plug('nvim-telescope/telescope.nvim')

-- Harpoon
--Plug('ThePrimeagen/harpoon', { ['branch'] = 'harpoon2' })

-- End of Plugins
vim.call('plug#end')
