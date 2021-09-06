-- Plugins
local packer = require('packer')
local use = packer.use

packer.reset()
packer.init {
    git = {
        clone_timeout = -1
    }
}

-- Packer
use 'wbthomason/packer.nvim'

-- Neovim GUI Shim
use { 'equalsraf/neovim-gui-shim', opt = true }

-- Colorscheme
use 'tomasiser/vim-code-dark'

-- Statusline
use '~/Workspace/neovim/feline'

-- Tabline
use {'romgrk/barbar.nvim', requires = {'kyazdani42/nvim-web-devicons'}}

-- Neovim icons
use 'kyazdani42/nvim-web-devicons'

-- Which Key
use 'folke/which-key.nvim'

-- Git
use 'tpope/vim-fugitive'
use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}

-- Surround
use 'tpope/vim-surround'

-- Comments
use 'b3nj5m1n/kommentary'

-- Delimit characters automatically
use 'Raimondi/delimitMate'

-- UNIX helper
use 'tpope/vim-eunuch'

-- Automatically change current directory
use 'airblade/vim-rooter'

-- Better buffer delete
use '~/Workspace/neovim/bufdelete'

-- LSP
use 'neovim/nvim-lspconfig' -- Configuration
use 'ray-x/lsp_signature.nvim' -- Signature Help
use 'kosayoda/nvim-lightbulb' -- Lightbulb on Code Action
use 'simrat39/symbols-outline.nvim' -- Symbols list
use 'onsails/lspkind-nvim' -- LSP Completion Item Icons

-- Telescope
use {
    'nvim-telescope/telescope.nvim',
    requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'}
}

use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

-- Better quickfix window
use 'kevinhwang91/nvim-bqf'

-- Completion and snippets
use {
    'hrsh7th/nvim-cmp',
    requires = {
        'hrsh7th/vim-vsnip',
        'hrsh7th/vim-vsnip-integ',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-vsnip',
        'hrsh7th/cmp-calc'
    }
}

-- Tresitter
use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
use 'nvim-treesitter/nvim-treesitter-textobjects'

-- Debugging
use 'mfussenegger/nvim-dap'
use 'mfussenegger/nvim-dap-python'
use 'theHamsta/nvim-dap-virtual-text'
use 'nvim-telescope/telescope-dap.nvim'
