-- GUI settings.
vim.o.guifont = 'FiraCode Nerd Font:h9.5'
vim.o.linespace = 1

-- Neovide specific settings.
if vim.g.neovide then
    vim.g.neovide_scale_factor = 1.0

    -- Go fullscreen with F11.
    vim.keymap.set('n', '<F11>', function()
        vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
    end, { silent = true })


    local function set_scale_factor(scale_factor)
        vim.g.neovide_scale_factor = scale_factor
        vim.cmd.redraw({ bang = true })
    end

    local function change_scale_factor(delta)
        set_scale_factor(vim.g.neovide_scale_factor + delta)
    end

    -- Add keymaps for scaling UI.
    vim.keymap.set('n', '<C-=>', function() change_scale_factor(0.25) end)
    vim.keymap.set('n', '<C-->', function() change_scale_factor(-0.25) end)
    vim.keymap.set('n', '<C-A-=>', function() set_scale_factor(1.0) end)
end
