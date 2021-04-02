local fn = vim.fn
local execute = vim.api.nvim_command

-- Restart Vim without having to close and run again
function Restart()
    -- Load config
    execute('luafile $MYVIMRC')

    -- Close all buffers
    execute('%bdelete')
    execute('BufferCloseAllButCurrent')

    -- Manually run VimEnter autocmd to emulate a new run of Vim
    execute('doautocmd VimEnter')
end

-- Reload Vim configuration
function Reload()
    execute('luafile $MYVIMRC')
end

-- Add commands for reload and restart
execute('command! Reload lua Reload()')
execute('command! Restart lua Restart()')

-- Set mapleader to space
vim.g.mapleader = ' '

-- Sensible defaults
require('settings')

-- Load keybinds
require('keybinds')

-- If Packer is not installed, download it and all plugins and reload config
-- If Packer is installed, load configuration as usual
local packer_install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(packer_install_path)) > 0
then
    -- Download Packer and add it
    execute('!git clone https://github.com/wbthomason/packer.nvim '..packer_install_path)
    execute('packadd packer.nvim')

    -- Load plugins
    require('plugins')

    -- Automatically sync packer and restart Vim
    execute('PackerSync')
    execute('autocmd User PackerComplete lua Restart()')
else
    -- Load plugins
    require('plugins')

    -- Load configuration
    require('config')

    -- Load statusline
    require('statusline')
end
