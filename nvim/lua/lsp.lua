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


    -- ==========================================================================
    -- 2. IMPACT ANALYSIS & REFERENCE NAVIGATION
    -- ==========================================================================

    if client:supports_method('textDocument/references') then
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    end

    -- Call Hierarchy
    if client:supports_method('textDocument/prepareCallHierarchy') then
      vim.keymap.set('n', 'gh', function()
        vim.lsp.buf.call_hierarchy()
      end, opts)
    end

    -- Reference Navigation (Quickfix list movement)
    -- These allow you to jump through the results of 'gr'
    vim.keymap.set('n', ']]', ':cnext<CR>', opts)
    vim.keymap.set('n', '[[', ':cprev<CR>', opts)
    vim.keymap.set('n', '<A-n>', ':cnext<CR>', opts)
    vim.keymap.set('n', '<A-p>', ':cprev<CR>', opts)


    -- ==========================================================================
    -- 3. BIRD'S EYE VIEW & CONTEXT
    -- ==========================================================================

    -- Symbols
    if client:supports_method('textDocument/documentSymbol') then
      vim.keymap.set('n', '<leader>s', vim.lsp.buf.document_symbol, opts)
    end

    if client:supports_method('workspace/symbol') then
      vim.keymap.set('n', '<leader>w', vim.lsp.buf.workspace_symbol, opts)
    end

    -- Hover & Signature Help
    if client:supports_method('textDocument/hover') then
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    end

    if client:supports_method('textDocument/signatureHelp') then
      vim.keymap.set('n', 'gK', vim.lsp.buf.signature_help, opts)
      vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)
    end


    -- ==========================================================================
    -- 4. CODE MODIFICATIONS & ACTIONS
    -- ==========================================================================

    -- Code Actions & Source Actions
    if client:supports_method('textDocument/codeAction') then
      -- Normal and Visual mode
      vim.keymap.set({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    end

    -- Rename
    if client:supports_method('textDocument/rename') then
      vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, opts)
    end

    -- Codelens
    if client:supports_method('textDocument/codelens') then
      vim.keymap.set({ 'n', 'x' }, '<leader>cl', function()
        vim.lsp.codelens.run()
      end, opts)
    end
  end,
})
