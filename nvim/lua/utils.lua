-- Create a Neovim user command to clear all registers (excluding clipboard)
vim.api.nvim_create_user_command("ClearRegisters", function()
  -- All standard, numbered, and special registers (excluding '*' and '+')
  local registers = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"*#+='

  for r in registers:gmatch(".") do
    vim.fn.setreg(r, "")
  end

  vim.notify("All registers cleared (clipboard excluded)", vim.log.levels.INFO)
end, {
  desc = "Clear all Vim registers except system clipboard",
})
