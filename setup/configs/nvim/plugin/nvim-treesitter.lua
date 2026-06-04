vim.pack.add{
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
}
require('nvim-treesitter').install { 'python', 'bash', 'typescript', 'markdown', 'markdown_inline', 'html', 'yaml', 'latex'}
