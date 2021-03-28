local bind = vim.api.nvim_buf_set_keymap
local utils = require('utils')

function GodotSettings()
	bind(0, 'n', '<F4>', ':GodotRunLast<CR>', { noremap = true })
	bind(0, 'n', '<F5>', ':GodotRun<CR>', { noremap = true })
	bind(0, 'n', '<F6>', ':GodotRunCurrent<CR>', { noremap = true })
	bind(0, 'n', '<F7>', ':GodotRunFZF<CR>', { noremap = true })
end

utils.create_augroup({
	{'FileType', 'gdscript', 'lua GodotSettings()'},
}, 'godot')
