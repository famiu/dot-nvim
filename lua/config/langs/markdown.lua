-- Markdown filetype settings
local bind = vim.api.nvim_buf_set_keymap

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

    require('whichkey_setup').register_keymap('localleader', keys)
end

require('utils').create_augroup({
	{'FileType', 'markdown', 'lua MarkdownSettings()'},
}, 'markdown')
