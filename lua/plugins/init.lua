vim.api.nvim_create_autocmd('PackChanged', {
    group = vim.api.nvim_create_augroup('pack-hooks', {}),
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if kind ~= 'install' and kind ~= 'update' then
            return
        end

        if name == 'nvim-treesitter' then
            if not ev.data.active then
                vim.cmd.packadd(name)
            end
            vim.cmd('TSUpdate')
        elseif name == 'blink.cmp' then
            if not ev.data.active then
                vim.cmd.packadd('blink.lib')
                vim.cmd.packadd(name)
            end
            require('blink.cmp').build():pwait()
        end
    end,
})

local startup_specs = {
    'https://github.com/nvim-neotest/nvim-nio',
    'https://github.com/mfussenegger/nvim-dap',
    'https://github.com/rcarriga/nvim-dap-ui',
    'https://github.com/theHamsta/nvim-dap-virtual-text',
    'https://github.com/saghen/blink.lib',
    'https://github.com/saghen/blink.cmp',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/stevearc/conform.nvim',
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/folke/flash.nvim',
    { src = 'https://github.com/ThePrimeagen/harpoon', version = 'harpoon2' },
    'https://github.com/sindrets/diffview.nvim',
    'https://github.com/lewis6991/gitsigns.nvim',
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/MunifTanjim/nui.nvim',
    { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },
    'https://github.com/folke/noice.nvim',
    'https://github.com/kevinhwang91/nvim-bqf',
    'https://github.com/folke/snacks.nvim',
    'https://github.com/nvim-lualine/lualine.nvim',
    'https://github.com/mason-org/mason.nvim',
    'https://github.com/stevearc/oil.nvim',
    'https://github.com/rmagatti/auto-session',
    'https://github.com/tpope/vim-sleuth',
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = 'main' },
    'https://github.com/nvim-mini/mini.ai',
    'https://github.com/nvim-mini/mini.align',
    'https://github.com/nvim-mini/mini.surround',
    'https://github.com/Wansmer/treesj',
    'https://github.com/lewis6991/spaceless.nvim',
}

vim.pack.add(startup_specs)

vim.pack.add({
    'https://github.com/OXY2DEV/markview.nvim',
    'https://github.com/chomosuke/typst-preview.nvim',
}, { load = function() end })

require('plugins.ui')
require('plugins.snacks')
require('plugins.treesitter')
require('plugins.misc')
require('plugins.lsp')
require('plugins.editing')
require('plugins.formatting')
require('plugins.navigation')
require('plugins.git')
require('plugins.sessions')
require('plugins.status_items')
require('plugins.dap')
