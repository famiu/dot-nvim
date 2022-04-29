-- Use impatient.nvim to load Lua modules faster
local fn = vim.fn
local cmd = vim.cmd

-- Configuration to load after loading plugins
local function load_post_plugin_config()
    require('plugins')
    require('impatient')  -- Use impatient.nvim to load Lua modules faster
    require('settings')
    require('keybinds')
    require('config')
end

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

    -- Automatically sync packer and load the rest of the config
    cmd('PackerSync')
    require('utils').create_augroup({
        {
            event = 'User PackerComplete',
            opts = { once = true, callback = load_post_plugin_config }
        }
    }, 'load_post_plugin_config')
else
    require('plugins')
    load_post_plugin_config()
end
