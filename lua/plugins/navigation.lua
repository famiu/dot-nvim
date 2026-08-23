local flash_opts = {
    jump = {
        autojump = true,
    },
    label = {
        uppercase = false,
    },
    modes = {
        search = {
            enabled = false,
        },
        char = {
            jump_labels = function(_)
                return vim.v.count == 0
            end,
        },
    },
}

-- Unmap <CR> in quickfix and command-line windows.
local flash_unmap_augroup = vim.api.nvim_create_augroup('FlashUnmapCR', {})
local flash_unmap_fn = function()
    vim.keymap.set('n', '<CR>', '<CR>', { buffer = 0 })
end

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'qf',
    callback = flash_unmap_fn,
    group = flash_unmap_augroup,
    desc = 'Unmap <CR> for quickfix windows',
})

vim.api.nvim_create_autocmd('CmdwinEnter', {
    callback = flash_unmap_fn,
    group = flash_unmap_augroup,
    desc = 'Unmap <CR> for command-line windows',
})

require('flash').setup(flash_opts)

vim.keymap.set({ 'n', 'x', 'o' }, '<CR>', function()
    require('flash').jump()
end, { desc = 'Flash' })
vim.keymap.set({ 'n', 'x', 'o' }, '<S-CR>', function()
    require('flash').treesitter()
end, { desc = 'Flash Treesitter' })
vim.keymap.set('o', 'r', function()
    require('flash').remote()
end, { desc = 'Remote Flash' })
vim.keymap.set('c', '<C-s>', function()
    require('flash').toggle()
end, { desc = 'Toggle Flash Search' })

-- Always toggle flash search jump labels off after entering cmdline, so that
-- the <C-s> keybind only applies for the current search.
vim.api.nvim_create_autocmd('CmdlineEnter', {
    callback = function(_)
        if vim.v.event.cmdtype:match('[/?]') then
            require('flash').toggle(false)
        end
    end,
    group = vim.api.nvim_create_augroup('FlashCmdlineToggle', {}),
    desc = 'Toggle Flash search jump labels off when entering cmdline',
})

local harpoon = require('harpoon')
local extensions = require('harpoon.extensions')
harpoon:setup({})

harpoon:extend(extensions.builtins.highlight_current_file())
harpoon:extend(extensions.builtins.navigate_with_number())

harpoon:extend({
    UI_CREATE = function(cx)
        vim.keymap.set('n', '<C-v>', function()
            harpoon.ui:select_menu_item({ vsplit = true })
        end, { buffer = cx.bufnr })

        vim.keymap.set('n', '<C-x>', function()
            harpoon.ui:select_menu_item({ split = true })
        end, { buffer = cx.bufnr })

        vim.keymap.set('n', '<C-t>', function()
            harpoon.ui:select_menu_item({ tabedit = true })
        end, { buffer = cx.bufnr })
    end,
})

vim.keymap.set('n', '<Leader>za', function()
    harpoon:list():add()
end)
vim.keymap.set('n', '<Leader>zc', function()
    harpoon:list():clear()
end)
vim.keymap.set('n', '<Leader>zz', function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
end)
vim.keymap.set('n', '<Leader>]', function()
    harpoon:list():next()
end)
vim.keymap.set('n', '<Leader>[', function()
    harpoon:list():prev()
end)
vim.keymap.set('n', '<Leader>1', function()
    harpoon:list():select(1)
end)
vim.keymap.set('n', '<Leader>2', function()
    harpoon:list():select(2)
end)
vim.keymap.set('n', '<Leader>3', function()
    harpoon:list():select(3)
end)
vim.keymap.set('n', '<Leader>4', function()
    harpoon:list():select(4)
end)
