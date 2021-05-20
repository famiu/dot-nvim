-- Markdown filetype settings
local bind = vim.api.nvim_buf_set_keymap
local bufnr = vim.api.nvim_get_current_buf()

function MarkdownSettings()
    require('utils').set_buffer_soft_line_nagivation()

    bind(0, 'n', '<LocalLeader>p', '<Plug>MarkdownPreview', {})
    bind(0, 'n', '<LocalLeader>s', '<Plug>MarkdownPreviewStop', {})
    bind(0, 'n', '<LocalLeader>t', '<Plug>MarkdownPreviewToggle', {})

    local keys = {
        p = 'Preview',
        s = 'Stop preview',
        t = 'Toggle preview'
    }

    require('which-key').register(keys, { prefix = "<localleader>", buffer = bufnr })
end

require('utils').create_augroup({
	{'FileType', 'markdown', 'lua MarkdownSettings()'},
}, 'markdown')
