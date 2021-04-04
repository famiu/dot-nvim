local fn = vim.fn
local cmd = vim.cmd

-- Add commands for reload and restart
cmd('command! Reload lua require("utils").Reload()')
cmd('command! Restart lua require("utils").Restart()')

-- Set mapleader to space
vim.g.mapleader = ' '

-- Set localleader to comma
vim.g.maplocalleader = ','

-- Sensible defaults
require('settings')

-- If Packer is not installed, download it and all plugins and reload config
-- If Packer is installed, load configuration as usual
local packer_install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(packer_install_path)) > 0
then
    -- Download Packer and add it
    cmd('!git clone https://github.com/wbthomason/packer.nvim '..packer_install_path)
    cmd('packadd packer.nvim')

    -- Load plugins
    require('plugins')

    -- Automatically sync packer and restart Vim
    cmd('PackerSync')
    require('utils').create_augroup({
        {'User', 'PackerComplete', 'lua require("utils").Restart()'}
    }, 'init_reload_after_packer')
else
    -- Load plugins
    require('plugins')

    -- Load keybinds
    require('keybinds')

    -- Load configuration
    require('config')

    -- Load statusline
    require('statusline')
end
