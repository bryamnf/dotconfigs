-- Leader key
vim.g.mapleader = " "

-- Relative number
vim.o.relativenumber = true
vim.o.number = true

-- Clipboard
vim.api.nvim_set_option("clipboard", "unnamedplus")

-- LSP
vim.lsp.log.set_level('warn')

-- Set tab and indentation to 2 spaces
vim.opt.tabstop = 4        -- Number of visual spaces per TAB
vim.opt.softtabstop = 4    -- Number of spaces in tab when editing
vim.opt.shiftwidth = 4     -- Number of spaces for each indentation
vim.opt.expandtab = true   -- Use spaces instead of tabs
vim.opt.smartindent = true -- Autoindent new lines
vim.opt.autoindent = true  -- Copy indent from current line when starting a new one
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.smartindent = true
    vim.opt_local.autoindent = true
  end,
})
