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
-- Per-buffer horizontal jump history
local hjumps = {}  -- { [bufnr] = { stack = {{line, col}, ...}, idx = N, line = L } }

local function get_state()
  local buf = vim.api.nvim_get_current_buf()
  local cur_line = vim.api.nvim_win_get_cursor(0)[1]
  local s = hjumps[buf]
  if not s or s.line ~= cur_line then
    s = { stack = {}, idx = 0, line = cur_line }
    hjumps[buf] = s
  end
  return s
end

local function record()
  local s = get_state()
  local pos = vim.api.nvim_win_get_cursor(0)
  for i = #s.stack, s.idx + 1, -1 do
    s.stack[i] = nil
  end
  table.insert(s.stack, pos)
  s.idx = #s.stack
end

local function hjump(motion)
  return function()
    record()
    vim.cmd('normal! ' .. motion)
    local s = get_state()
    table.insert(s.stack, vim.api.nvim_win_get_cursor(0))
    s.idx = #s.stack
  end
end

local function hback()
  local s = get_state()
  if s.idx > 1 then
    s.idx = s.idx - 1
    vim.api.nvim_win_set_cursor(0, s.stack[s.idx])
  end
end

local function hforward()
  local s = get_state()
  if s.idx < #s.stack then
    s.idx = s.idx + 1
    vim.api.nvim_win_set_cursor(0, s.stack[s.idx])
  end
end

-- Clear the stack whenever the cursor moves to a different line
vim.api.nvim_create_autocmd('CursorMoved', {
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    local s = hjumps[buf]
    if s and s.line ~= vim.api.nvim_win_get_cursor(0)[1] then
      hjumps[buf] = nil
    end
  end,
})

vim.keymap.set('n', '$', hjump('$'))
vim.keymap.set('n', '0', hjump('0'))

vim.keymap.set('n', '<A-o>', hback,    { desc = 'Horizontal jump back' })
vim.keymap.set('n', '<A-i>', hforward, { desc = 'Horizontal jump forward' })
