require "user.options"
require "user.keymaps"
require "user.statusline"
require "user.autocommands"
require "user.lsp"
require "user.diagnostic"
require "user.ft-overrides"

local gh = function(x) return 'https://github.com/' .. x end

vim.pack.add({
    gh 'tpope/vim-surround',
    { src = gh 'saghen/blink.cmp', version = vim.version.range('1') },
    { src = gh 'everviolet/nvim',  name = 'evergarden' },
    gh 'mason-org/mason.nvim',
    gh 'seblyng/roslyn.nvim',
    { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' },
})

require "user.plugins.colorscheme"
require "user.plugins.autocomplete"
require "user.plugins.lsp"
require "user.plugins.treesitter"
