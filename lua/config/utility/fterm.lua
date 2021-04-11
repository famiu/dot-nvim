require('FTerm').setup()

local bind = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

bind('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>', opts)
bind('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opts)
