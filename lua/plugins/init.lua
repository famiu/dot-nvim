-- Boostrap lazy.nvim if needed
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    -- Colorscheme
    {
        'EdenEast/nightfox.nvim',
        config = function()
            require('nightfox').setup({})
            vim.cmd.colorscheme('carbonfox')
        end
    },
    -- LSP
    {
        'williamboman/mason.nvim',
        opts = {
            PATH = 'append',
            pip = { upgrade_pip = true },
            max_concurrent_installers = PU_COUNT
        }
    },
    -- Completion and snippets
    {
        'L3MON4D3/LuaSnip',
        build = 'make install_jsregexp'
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
        },
        config = function() require('plugins.cmp') end
    },
    -- DAP
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'theHamsta/nvim-dap-virtual-text'
        },
        config = function() require('plugins.dap') end
    },
    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects'
        },
        config = function() require('plugins.treesitter') end,
        build = ':TSUpdate'
    },
    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-ui-select.nvim'
        },
        config = function() require('plugins.telescope') end
    },
    -- Git
    { 'tpope/vim-fugitive', config = function() require('plugins.fugitive') end },
    {
        'lewis6991/gitsigns.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        config = function() require('plugins.gitsigns') end
    },
    -- Statusline
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'kyazdani42/nvim-web-devicons', 'SmiteshP/nvim-navic' },
        config = function() require('plugins.lualine') end
    },
    -- Neovim development
    { 'folke/neodev.nvim',  opts = { lspconfig = false } },
    -- UI Enhancements
    {
        'folke/noice.nvim',
        dependencies = {
            'MunifTanjim/nui.nvim',
            'rcarriga/nvim-notify'
        },
        opts = {
            lsp = {
                override = {
                    ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                    ['vim.lsp.util.stylize_markdown'] = true,
                    ['cmp.entry.get_documentation'] = false,
                },
                hover = { enabled = false },
                signature = { enabled = false },
            },
            presets = {
                bottom_search = true, -- use a classic bottom cmdline for search
                command_palette = false, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = true, -- add a border to hover docs and signature help
            },
        }
    },
    -- Motion
    { 'ggandor/leap.nvim', config = function() require('leap').add_default_mappings(true) end },
    -- Other useful stuff
    { dir = '~/Workspace/neovim/bufdelete' }, -- https://github.com/famiu/bufdelete.nvim
    { 'numToStr/Comment.nvim', config = true },
    { 'windwp/nvim-autopairs', config = true },
    { 'echasnovski/mini.align', config = function() require('mini.align').setup() end },
    'tpope/vim-surround',
    'tpope/vim-sleuth',
    'tpope/vim-eunuch',
}, {})
