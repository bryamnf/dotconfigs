-- Create a group to prevent duplicate autocmds
local lsp_group = vim.api.nvim_create_augroup('my.lsp_navigation', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
    group = lsp_group,
    callback = function(ev)
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
        local bufnr = ev.buf
        local opts = { noremap = true, silent = true, buffer = bufnr }

        -- ==========================================================================
        -- 1. DIRECT JUMPS (Point A -> Point B)
        -- ==========================================================================
        if client:supports_method('textDocument/definition') then
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        end

        if client:supports_method('textDocument/declaration') then
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        end

        if client:supports_method('textDocument/typeDefinition') then
            vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
        end

        if client:supports_method('textDocument/implementation') then
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        end

        -- Reference Navigation (Quickfix list movement)
        -- These allow you to jump through the list of Reference
        vim.keymap.set('n', ']]', ':cnext<CR>', opts)
        vim.keymap.set('n', '[[', ':cprev<CR>', opts)

        -- Rename
        if client:supports_method('textDocument/rename') then
            vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, opts)
        end

        -- Formatting
        if client:supports_method('textDocument/formatting') then
            -- Manual format with `ff`
            vim.keymap.set('n', 'ff', function()
                vim.lsp.buf.format({ async = true })
            end, opts)
            -- Format on save
            vim.api.nvim_create_autocmd('BufWritePre', {
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ async = false, id = client.id })
                end,
            })
        end
    end,
})
