-- Tree-sitter
require'nvim-treesitter.configs'.setup {
	ensure_installed = {'c', 'cpp', 'python', 'gdscript', 'rust', 'bash', 'lua'},
  	highlight = {
		enable = true,
		disable = {},
  	},
  	incremental_selection = {
		enable = true,
		keymaps = {
		    init_selection = "gnn",
		  	node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},
  	indent = {
		enable = true
	},
}
