-- Plugins
local packer = require('packer')
local use = packer.use

packer.reset()
packer.init {
    git = {
        clone_timeout = -1
    }
}

-- Neovim package manager
use 'wbthomason/packer.nvim'

-- Load Lua modules faster
use 'lewis6991/impatient.nvim'

-- Colorscheme
use 'Mofiqul/vscode.nvim'

-- Git
use 'tpope/vim-fugitive'
use { 'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim' }

-- Surround
use 'tpope/vim-surround'

-- Automatically detect indentation
use 'tpope/vim-sleuth'

-- Comments
use 'b3nj5m1n/kommentary'

-- Delimit characters automatically
use 'windwp/nvim-autopairs'

-- Project management
use 'ahmedkhalf/project.nvim'

-- LSP
use 'neovim/nvim-lspconfig'
use 'williamboman/nvim-lsp-installer'

-- DAP
use 'mfussenegger/nvim-dap'
use 'rcarriga/nvim-dap-ui'
use 'theHamsta/nvim-dap-virtual-text'

-- Telescope
use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' }
}
use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
use { 'nvim-telescope/telescope-ui-select.nvim' }

-- Better quickfix window
use 'kevinhwang91/nvim-bqf'

-- Completion and snippets
use 'L3MON4D3/LuaSnip'
use 'hrsh7th/nvim-cmp'
use 'hrsh7th/cmp-path'
use 'hrsh7th/cmp-nvim-lsp'
use 'hrsh7th/cmp-nvim-lua'

-- Tresitter
use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
use 'nvim-treesitter/nvim-treesitter-textobjects'
use 'SmiteshP/nvim-gps'

-- Local plugins, use URL if not locally available
if vim.fn.isdirectory(vim.fn.expand('~/Workspace/neovim/feline')) == 1 then
    use { '~/Workspace/neovim/feline', requires = 'kyazdani42/nvim-web-devicons' }
else
    use { 'feline-nvim/feline.nvim', requires = 'kyazdani42/nvim-web-devicons' }
end

if vim.fn.isdirectory(vim.fn.expand('~/Workspace/neovim/bufdelete')) == 1 then
    use '~/Workspace/neovim/bufdelete'
else
    use 'famiu/bufdelete.nvim'
end
