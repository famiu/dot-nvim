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

-- Neovim GUI Shim
use { 'equalsraf/neovim-gui-shim', opt = true }

-- Colorscheme
use 'Mofiqul/vscode.nvim'

-- Statusline
use { '~/Workspace/neovim/feline', requires = 'kyazdani42/nvim-web-devicons' }

-- File tree view
use { 'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons' }

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

-- Better buffer delete
use '~/Workspace/neovim/bufdelete'

-- LSP
use 'neovim/nvim-lspconfig' -- Configuration

-- Telescope
use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' }
}
use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

-- Better quickfix window
use 'kevinhwang91/nvim-bqf'

-- Completion and snippets
use 'L3MON4D3/LuaSnip'
use {
    'hrsh7th/nvim-cmp',
    requires = {
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
    }
}

-- Tresitter
use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
use 'nvim-treesitter/nvim-treesitter-textobjects'
use 'SmiteshP/nvim-gps'
use 'haringsrob/nvim_context_vt'
