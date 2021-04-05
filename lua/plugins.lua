-- Plugins
local use = require('packer').use

return require('packer').startup(function()
    -- Packer
    use 'wbthomason/packer.nvim'

    -- Neovim GUI Shim
    use { 'equalsraf/neovim-gui-shim', opt = true }

    -- Colorscheme
    use 'tomasiser/vim-code-dark'

    -- Tab bar
    use 'akinsho/nvim-bufferline.lua'

    -- Statusline
    use { 'glepnir/galaxyline.nvim', branch = 'main' }

    -- Start screen
    use 'mhinz/vim-startify'

    -- Colorize color codes
    use 'chrisbra/Colorizer'

    -- Neovim icons
    use 'kyazdani42/nvim-web-devicons'

    -- File Tree
    use 'kyazdani42/nvim-tree.lua'

    -- Git
    use 'tpope/vim-fugitive'
    use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}
    use 'junegunn/gv.vim'

    -- Undo Tree
    use 'mbbill/undotree'

    -- Register Preview
    use 'gennaro-tedesco/nvim-peekup'

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

    -- Delimit
    use 'Raimondi/delimitMate'

    -- Remember last location in file
    use 'farmergreg/vim-lastplace'

    -- UNIX helper
    use 'tpope/vim-eunuch'

    -- Automatically change current directory
    use 'airblade/vim-rooter'

    -- Editorconfig
    use 'editorconfig/editorconfig-vim'

    -- Snippets
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'

    -- LSP
    use 'neovim/nvim-lsp'
    use 'onsails/lspkind-nvim'
    use 'ray-x/lsp_signature.nvim'
    use 'kosayoda/nvim-lightbulb'

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }

    -- Search and replace across multiple files
    use 'brooth/far.vim'

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

    -- Godot
    use 'habamax/vim-godot'

    -- Markdown preview
    use {
        'iamcco/markdown-preview.nvim',
        run = function() vim.fn['mkdp#util#install']() end
    }

    -- Which Key
    use {
        'AckslD/nvim-whichkey-setup.lua',
        requires = {'liuchengxu/vim-which-key'},
    }

    -- Meta
    -- Read line and column from the command line
    use 'wsdjeg/vim-fetch'

    -- Misc
    -- Discord Rich Presence
    use 'andweeb/presence.nvim'
end)
