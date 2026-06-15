vim.pack.add {
    { src = 'https://github.com/milanglacier/minuet-ai.nvim', version = 'main' },
}

require('minuet').setup {
    virtualtext = {
        notity = "debug",
        auto_trigger_ft = {},
        keymap = {
            -- accept whole completion
            accept = '<A-A>',
            -- accept one line
            accept_line = '<A-a>',
            -- accept n lines (prompts for number)
            -- e.g. "A-z 2 CR" will accept 2 lines
            accept_n_lines = '<A-z>',
            -- Cycle to prev completion item, or manually invoke completion
            prev = '<A-[>',
            -- Cycle to next completion item, or manually invoke completion
            next = '<A-]>',
            dismiss = '<A-e>',
        },
    },
    provider = 'openai_fim_compatible',
    n_completions = 1, -- recommend for local model for resource saving
    -- I recommend beginning with a small context window size and incrementally
    -- expanding it, depending on your local computing power. A context window
    -- of 512, serves as an good starting point to estimate your computing
    -- power. Once you have a reliable estimate of your local computing power,
    -- you should adjust the context window to a larger value.
    context_window = 500,
    provider_options = {
        openai_fim_compatible = {
            api_key = 'APPHUBAI_API_KEY',

            name = 'Ollama',
            end_point = 'https://apphubai.wolke.uni-greifswald.de/v1/completions',
            model = 'qwen2.5-coder:7b',
            stream = true,
        },
    },
}

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
keymap({ 'n', 'v' }, '<leader>m', ':Minuet virtualtext toggle <CR>', opts)
