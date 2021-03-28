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
	use 'romgrk/barbar.nvim'

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

	-- Fuzzy finder
	use 'junegunn/fzf.vim'

	-- Git
	use 'tpope/vim-fugitive'
	use 'airblade/vim-gitgutter'
	use 'junegunn/gv.vim'

	-- Undo Tree
	use 'mbbill/undotree'

	-- Terminal
	use 'skywind3000/vim-terminal-help'

	-- Surround
	use 'tpope/vim-surround'

	-- Comments
	use 'tpope/vim-commentary'

	-- Tabs and text alignment
	use 'godlygeek/tabular'

	-- Delimit
	use 'Raimondi/delimitMate'

	-- Remember last location in file
	use 'farmergreg/vim-lastplace'

	-- UNIX helper
	use 'tpope/vim-eunuch'

	-- Editorconfig
	use 'editorconfig/editorconfig-vim'

	-- Easymotion
	use 'easymotion/vim-easymotion'

	-- Snippets
	use 'hrsh7th/vim-vsnip'
	use 'hrsh7th/vim-vsnip-integ'

	-- LSP
	use 'neovim/nvim-lsp'
	use 'glepnir/lspsaga.nvim'

	-- Completion
	use 'hrsh7th/nvim-compe'

	-- Tresitter
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

	-- LSP Install
	use 'kabouzeid/nvim-lspinstall'

	-- Debugging
	use 'mfussenegger/nvim-dap'

	-- Extra language support
	-- GDScript
	use 'habamax/vim-godot'

	-- Meta
	-- Read line and column from the command line
	use 'wsdjeg/vim-fetch'

	-- Sensible defaults
	use 'tpope/vim-sensible'
end)
