local g = vim.g
local bind = vim.api.nvim_buf_set_keymap

g.mkdp_auto_start = 0
g.mkdp_auto_close = 0
g.mkdp_refresh_slow = 0
g.mkdp_command_for_global = 0
g.mkdp_open_to_the_world = 0
g.mkdp_open_ip = ''
g.mkdp_browser = ''
g.mkdp_echo_preview_url = 0
g.mkdp_browserfunc = ''
g.mkdp_preview_options = {
    mkit = {},
    katex = {},
    uml = {},
    maid = {},
    disable_sync_scroll = 0,
    sync_scroll_type = 'middle',
    hide_yaml_meta = 1,
    sequence_diagrams = {},
    flowchart_diagrams = {},
    content_editable = false,
    disable_filename = 0
}
g.mkdp_markdown_css = ''
g.mkdp_highlight_css = ''

-- use a custom port to start server or random for empty
g.mkdp_port = ''

-- preview page title
-- ${name} will be replace with the file name
g.mkdp_page_title = '「${name}」'

-- recognized filetypes
-- these filetypes will have MarkdownPreview... commands
g.mkdp_filetypes = {'markdown'}
