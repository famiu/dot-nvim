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

-- Tab bar
use 'akinsho/nvim-bufferline.lua'

-- Start screen
use 'mhinz/vim-startify'

-- Colorize color codes
use 'chrisbra/Colorizer'

-- Neovim icons
use 'kyazdani42/nvim-web-devicons'

-- Indent guides
use {'lukas-reineke/indent-blankline.nvim', branch = 'lua'}

-- Which Key
use 'folke/which-key.nvim'

-- Smooth scrolling
use 'psliwka/vim-smoothie'

-- File Tree
use 'kyazdani42/nvim-tree.lua'

-- Git
use 'tpope/vim-fugitive'
use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}
use 'junegunn/gv.vim'

-- Undo Tree
use 'mbbill/undotree'

-- Terminal
use 'akinsho/nvim-toggleterm.lua'

-- Color Picker
use 'KabbAmine/vCoolor.vim'

-- Surround
use 'tpope/vim-surround'

-- Comments
use 'b3nj5m1n/kommentary'

-- Tabs and text alignment
use 'godlygeek/tabular'

-- Delimit characters automatically
use 'Raimondi/delimitMate'

-- Remember last location in file
use 'farmergreg/vim-lastplace'

-- UNIX helper
use 'tpope/vim-eunuch'

-- Automatically change current directory
use 'airblade/vim-rooter'

-- Snippets
use 'hrsh7th/vim-vsnip'
use 'hrsh7th/vim-vsnip-integ'

-- LSP
use 'neovim/nvim-lspconfig' -- Configuration
use 'onsails/lspkind-nvim' -- Completion Icons
use 'ray-x/lsp_signature.nvim' -- Signature Help
use 'kosayoda/nvim-lightbulb' -- Lightbulb on Code Action
use 'simrat39/symbols-outline.nvim' -- Symbols list

-- Luadev
use 'rafcamlet/nvim-luapad'

-- Telescope
use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
}

-- Better quickfix window
use 'kevinhwang91/nvim-bqf'

-- Completion
use 'hrsh7th/nvim-compe'

-- Tresitter
use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
use 'nvim-treesitter/nvim-treesitter-textobjects'

-- LSP Install
use 'kabouzeid/nvim-lspinstall'

-- Debugging
use 'mfussenegger/nvim-dap'
use 'mfussenegger/nvim-dap-python'
use 'theHamsta/nvim-dap-virtual-text'
use 'nvim-telescope/telescope-dap.nvim'

-- Markdown preview
use {
    'iamcco/markdown-preview.nvim',
    run = function() vim.fn['mkdp#util#install']() end
}

-- Misc
-- Discord Rich Presence
use 'andweeb/presence.nvim'

-- Profiler
use { 'norcalli/profiler.nvim', opt = true }

-- Reload config
use '~/Workspace/neovim/reload'
