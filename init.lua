local fn = vim.fn
local execute = vim.api.nvim_command

-- Set mapleader to space
vim.g.mapleader = ' '

-- Sensible defaults
require('settings')

-- Bootstrap Packer
local packer_install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(packer_install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim '..packer_install_path)
    execute('packadd packer.nvim')
end

-- Load plugins
require('plugins')

-- Load keybinds
require('keybinds')

-- Load configuration
require('config')

-- All LSP and LSP-related configurations
require('lsp')

-- Load statusline
require('statusline')
