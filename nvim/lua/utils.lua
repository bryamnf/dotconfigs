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

-- Easier lsp enable
vim.api.nvim_create_user_command('LspEnable', function(opts)
    local lang = opts.args
    local success, err = pcall(function() vim.lsp.enable(lang) end)
    if success then print("LSP enabled: " .. lang) else print("Error: " .. err) end
end, { 
    nargs = 1, 
    complete = function()
        local lsp_dir = vim.fn.stdpath("config") .. "/lsp/"

        -- Safety check: return empty list if directory doesn't exist
        if vim.fn.isdirectory(lsp_dir) == 0 then 
            return {} 
        end

        local files = vim.fn.readdir(lsp_dir)
        local langs = {}
        for _, file in ipairs(files) do
            -- Remove the .lua extension from the filename
            table.insert(langs, (file:gsub("%.lua$", "")))
        end
        return langs
    end,
})
