-- Set your leader key
vim.g.mapleader = " "

-- Create a group to prevent duplicate autocmds when reloading config
local lsp_group = vim.api.nvim_create_augroup('my.lsp_navigation', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
  group = lsp_group,
  callback = function(ev)
    -- Get the client and buffer from the event
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    local bufnr = ev.buf
    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- ==========================================================================
    -- 1. DIRECT JUMPS (Point A -> Point B)
    -- ==========================================================================
    
    -- Go to Definition
    if client:supports_method('textDocument/definition') then
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    end

    -- Go to Type Definition
    if client:supports_method('textDocument/typeDefinition') then
      vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
    end

    -- Go to Implementation
    if client:supports_method('textDocument/implementation') then
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    end


    -- ==========================================================================
    -- 2. IMPACT ANALYSIS (Where else is this?)
    -- ==========================================================================

    -- Find References
    if client:supports_method('textDocument/references') then
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    end

    -- Call Hierarchy
    if client:supports_method('textDocument/prepareCallHierarchy') then
      vim.keymap.set('n', 'gh', function()
        vim.lsp.buf.call_hierarchy()
      end, opts)
    end


    -- ==========================================================================
    -- 3. BIRD'S EYE VIEW (Scanning)
    -- ==========================================================================

    -- Document Symbols (Current File)
    if client:supports_method('textDocument/documentSymbol') then
      vim.keymap.set('n', '<leader>ds', vim.lsp.buf.document_symbol, opts)
    end

    -- Workspace Symbols (Entire Project)
    if client:supports_method('workspace/symbol') then
      vim.keymap.set('n', '<leader>ws', vim.lsp.buf.workspace_symbol, opts)
    end
  end,
})
