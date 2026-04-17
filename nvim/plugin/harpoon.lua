vim.pack.add{
    { src = 'https://github.com/nvim-lua/plenary.nvim' },
    { src = 'https://github.com/ThePrimeagen/harpoon', version = 'harpoon2' },
}
local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

-- fzf-lua integration for harpoon
local function toggle_fzf_harpoon()
    local harpoon_files = harpoon:list()
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("fzf-lua").fzf_exec(file_paths, {
        prompt = "Harpoon> ",
        preview = "bat --style=numbers --color=always {} || cat {}",
        fzf_opts = {
            ["--preview-window"] = "nohidden,right,50%",
        },
        actions = {
            ["default"] = function(selected)
                vim.cmd("edit " .. selected[1])
            end,
            ["ctrl-x"] = function(selected)
                for i, item in ipairs(harpoon_files.items) do
                    if item.value == selected[1] then
                        harpoon:list():remove_at(i)
                        break
                    end
                end
            end,
        },
    })
end
vim.keymap.set("n", "<leader>h", toggle_fzf_harpoon)


vim.keymap.set("n", "<C-a>", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-d>", function() harpoon:list():remove() end)

vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>p", function() harpoon:list():prev() end)
vim.keymap.set("n", "<leader>n", function() harpoon:list():next() end)
